import 'package:flutter/material.dart';

class ApptimeField extends StatelessWidget {
  final String label;
  final TimeOfDay? time;
  final VoidCallback onTap;

  const ApptimeField({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
  });
  static String formatTime(TimeOfDay time) {
    // la n7awelon la time bi neseb l my sql
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes:00';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        child: Text(
          time != null ? formatTime(time!) : "Select $label",
          style: TextStyle(color: time != null ? Colors.black : Colors.grey),
        ),
      ),
    );
  }
}
