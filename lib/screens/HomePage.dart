// package
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// auth
import 'package:tracky/auth/Auth.dart';

// components
import 'package:tracky/components/DashboardCards.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedLogout01),
            onPressed: () async {
              // TODO: Navigate to Profile Page
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withAlpha(75),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Admin",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Divider(color: Theme.of(context).colorScheme.surface, thickness: 1.5),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashboardCard(
                      text: "Profile",
                      icon: HugeIcons.strokeRoundedUser02,
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    DashboardCard(
                      text: "Mark Attendance",
                      icon: HugeIcons.strokeRoundedCamera02,
                      onTap: () => Navigator.pushNamed(context, '/camera'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
