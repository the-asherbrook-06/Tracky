// ignore_for_file: use_build_context_synchronously

// packages
import 'dart:developer';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// screens
import 'package:tracky/screens/attendancescreen.dart';

import '../auth/Auth.dart';

Set<String> _detectedStudents = {};

class MarkAttendance extends StatefulWidget {
  final List<CameraDescription> cameras;

  const MarkAttendance({super.key, required this.cameras});

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  CameraController? _cameraController;
  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _isDetecting = false;
  String _result = 'Loading...';
  final int inputSize = 224;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // Load model
      _interpreter = await Interpreter.fromAsset('assets/models/model.tflite');

      // Load labels
      final labelsRaw = await DefaultAssetBundle.of(context).loadString('assets/models/labels.txt');
      _labels = labelsRaw.split('\n');

      // Initialize camera
      final camera = widget.cameras.first;
      _cameraController = CameraController(camera, ResolutionPreset.low);
      await _cameraController!.initialize();
      await _cameraController!.startImageStream(_onCameraImage);

      setState(() {});
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  void _onCameraImage(CameraImage image) async {
    if (_isDetecting || _interpreter == null) return;
    _isDetecting = true;

    try {
      final converted = _convertCameraImage(image);
      final resized = img.copyResize(converted, width: inputSize, height: inputSize);
      final input = _imageToByteListFloat32(resized);

      var output = List.filled(5, 0.0).reshape([1, 5]);
      _interpreter!.run(input, output);

      final scores = output[0];
      double maxScore = 0;
      int maxIndex = 0;
      for (int i = 0; i < scores.length; i++) {
        if (scores[i] > maxScore) {
          maxScore = scores[i];
          maxIndex = i;
        }
      }
      final detectedLabel = _labels[maxIndex];
      _detectedStudents.add(detectedLabel);

      setState(() {
        _result = "${_labels[maxIndex]} ${(maxScore * 100).toStringAsFixed(1)}%";
      });

      await Future.delayed(const Duration(milliseconds: 50));
    } catch (e) {
      debugPrint('Inference error: $e');
    } finally {
      _isDetecting = false;
    }
  }

  List<List<List<List<double>>>> _imageToByteListFloat32(img.Image image) {
    return [
      List.generate(inputSize, (y) {
        return List.generate(inputSize, (x) {
          final pixel = image.getPixel(x, y);
          return [
            pixel.r.toDouble() / 255.0,
            pixel.g.toDouble() / 255.0,
            pixel.b.toDouble() / 255.0,
          ];
        });
      })
    ];
  }

  img.Image _convertCameraImage(CameraImage image) {
    final width = image.width;
    final height = image.height;
    final imgData = img.Image(width: width, height: height);
    final uvRowStride = image.planes[1].bytesPerRow;
    final uvPixelStride = image.planes[1].bytesPerPixel ?? 1;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final uvIndex = uvPixelStride * (x ~/ 2) + uvRowStride * (y ~/ 2);
        final yp = image.planes[0].bytes[y * image.planes[0].bytesPerRow + x];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];

        int r = (yp + 1.370705 * (vp - 128)).round();
        int g = (yp - 0.337633 * (up - 128) - 0.698001 * (vp - 128)).round();
        int b = (yp + 1.732446 * (up - 128)).round();

        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        imgData.setPixelRgba(x, y, r, g, b, 255);
      }
    }
    return imgData;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mark Attendance"),
      ),
      body: (_cameraController == null || !_cameraController!.value.isInitialized)
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: _cameraController!.value.previewSize!.height,
                      height: _cameraController!.value.previewSize!.width,
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _result,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 20,
                  right: 20,
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
                        final result = await authProvider.markAttendance(
                          detectedRollNumbers: _detectedStudents.toList(),
                        );

                        log(result.toString());

                        if (result != null) {
                          final present = List<String>.from(result['present']);
                          final all = [...present, ...List<String>.from(result['absent'])].toSet().toList();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendanceScreen(
                                allStudents: all,
                                presentStudents: present,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Failed to mark attendance.")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: const Text("View Attendance"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
