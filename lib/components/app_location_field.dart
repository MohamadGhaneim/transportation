import 'package:flutter/material.dart';

class UserLocationField extends StatelessWidget {
  final TextEditingController controller;
  const UserLocationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      //keyboardType: TextInputType.none,
      //enableInteractiveSelection: true,
      decoration: const InputDecoration(
        labelText: "location like : 12.544, 34.323",
        border: OutlineInputBorder(),
      ),
      onTap: () {
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
      },
    );
  }
}
