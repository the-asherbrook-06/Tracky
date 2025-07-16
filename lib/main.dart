import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tracky/camerapage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const Tracky());
}

class Tracky extends StatelessWidget {
  const Tracky({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tracky',
        routes: {
          '/': (context) => const WelcomePage(),
        });
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'tracky',
      home: LiveCameraTFLite(),
    );
  }
}
