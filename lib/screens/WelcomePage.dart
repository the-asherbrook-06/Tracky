// packages

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: width,
            ),
          ),
          Text(
            "Welcome to Tracky",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Where Attendance is breeze",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: width - 32,
            height: 48,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )),
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            width: width - 32,
            height: 48,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )),
          ),
          const SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}
