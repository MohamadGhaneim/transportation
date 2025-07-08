// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class AppDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: value,
      items:
          items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Container(
                width: double.infinity,
                child: Text(item, overflow: TextOverflow.ellipsis, maxLines: 1),
              ),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
