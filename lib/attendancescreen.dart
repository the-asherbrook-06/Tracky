import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  final List<String> allStudents;
  final List<String> presentStudents;

  const AttendanceScreen({
    super.key,
    required this.allStudents,
    required this.presentStudents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Summary')),
      body: ListView.builder(
        itemCount: allStudents.length,
        itemBuilder: (context, index) {
          final student = allStudents[index];
          final isPresent = presentStudents.contains(student);
          return ListTile(
            title: Text(student),
            trailing: Text(
              isPresent ? "Available" : "Not Available",
              style: TextStyle(
                color: isPresent ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
