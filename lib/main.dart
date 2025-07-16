// packages
import 'package:flutter/material.dart';

// screens
import 'package:tracky/screens/RegisterPage.dart';
import 'package:tracky/screens/WelcomePage.dart';
import 'package:tracky/screens/LoginPage.dart';
import 'package:tracky/screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Tracky());
}

class Tracky extends StatelessWidget {
  const Tracky({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.cyan, useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        title: 'tracky',
        routes: {
          '/': (context) => const WelcomePage(),
          '/register': (context) => const RegisterPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        });
  }
}