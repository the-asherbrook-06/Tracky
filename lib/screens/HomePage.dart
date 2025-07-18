// package
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// auth
import 'package:tracky/auth/Auth.dart';

// components
import 'package:tracky/components/DashboardCards.dart';
import 'package:tracky/components/StudentCard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, bool>?> _attendanceFuture;

  @override
  void initState() {
    super.initState();
    _fetchAttendance();
  }

  void _fetchAttendance() {
    _attendanceFuture = Provider.of<AuthProvider>(context, listen: false).getAttendanceByDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedLogout01),
            onPressed: () async {
              Provider.of<AuthProvider>(context, listen: false).logoutUser(context);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        // 👈 Pull to refresh support
        onRefresh: () async {
          setState(() {
            _fetchAttendance();
          });
        },
        child: ListView(
          children: [
            // --- Admin Block ---
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
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
                        text: "Mark Attendance",
                        icon: HugeIcons.strokeRoundedCamera02,
                        onTap: () {
                          Navigator.pushNamed(context, '/camera');
                          setState(() {
                            _fetchAttendance();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Attendance Block ---
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withAlpha(75),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Attendance",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Divider(color: Theme.of(context).colorScheme.surface, thickness: 1.5),
                  FutureBuilder<Map<String, bool>?>(
                    future: _attendanceFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError || !snapshot.hasData) {
                        return const Text("Failed to load attendance.");
                      }

                      final attendanceMap = snapshot.data!;
                      return Column(
                        children: attendanceMap.entries.map((entry) {
                          return StudentCard(name: entry.key, isPresent: entry.value);
                        }).toList(),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
