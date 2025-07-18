import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  final List<String> allStudents;

  const AttendanceScreen({
    super.key,
    required this.allStudents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Summary')),
      body: ListView.builder(
        itemCount: allStudents.length,
        itemBuilder: (context, index) {
          final student = allStudents[index];

          return ListTile(
            title: Text(student),
            trailing: const Text(
              "Available",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
