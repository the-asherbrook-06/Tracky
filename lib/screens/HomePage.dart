// package
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// auth

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedUser02),
            onPressed: () {
              // TODO: Navigate to Profile Page
            },
          ),
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedLogout02),
            onPressed: () {
              // TODO: Sign Out
            },
          )
        ],
      ),
    );
  }
}
