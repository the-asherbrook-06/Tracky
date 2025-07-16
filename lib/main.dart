import 'package:flutter/material.dart';

void main() {
  runApp(const Tracky());
}

class Tracky extends StatelessWidget {
  const Tracky({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tracky',
      routes: {
        '/': (context) => const WelcomePage(),
      }
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}