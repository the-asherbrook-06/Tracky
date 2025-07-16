// packages
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tracky/attendancescreen.dart';
import 'package:tracky/camerapage.dart';

// screens
import 'package:tracky/screens/RegisterPage.dart';
import 'package:tracky/screens/WelcomePage.dart';
import 'package:tracky/screens/LoginPage.dart';
import 'package:tracky/screens/HomePage.dart';

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
        initialRoute: '/camera',
        routes: {
          '/': (context) => const WelcomePage(),
          '/register': (context) => const RegisterPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/camera': (context) => const LiveCameraTFLite(),
        });
  }
}