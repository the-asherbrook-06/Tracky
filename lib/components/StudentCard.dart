// packages
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.name, required this.isPresent});

  final String name;
  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      trailing: Icon(
        isPresent ? HugeIcons.strokeRoundedCheckmarkCircle01 : HugeIcons.strokeRoundedCancelCircle,
        color: isPresent ? Colors.green : Colors.red,
      ),
    );
  }
}
