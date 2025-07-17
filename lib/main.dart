// packages
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// screens
import 'package:tracky/screens/CameraPage.dart';
import 'package:tracky/screens/ProfilePage.dart';
import 'package:tracky/screens/RegisterPage.dart';
import 'package:tracky/screens/WelcomePage.dart';
import 'package:tracky/screens/LoginPage.dart';
import 'package:tracky/screens/HomePage.dart';

// auth
import 'auth/Auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const Tracky(),
    ),
  );
}


class Tracky extends StatelessWidget {
  const Tracky({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tracky',
        theme: ThemeData(colorSchemeSeed: Colors.green, brightness: Brightness.light),
        darkTheme: ThemeData(colorSchemeSeed: Colors.green, brightness: Brightness.dark),
        routes: {
          '/': (context) => const WelcomePage(),
          '/register': (context) => const RegisterPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const DashboardPage(),
          '/camera': (context) => const MarkAttendance(),
          '/profile': (context) => const ProfilePage(),
        });
  }
}
