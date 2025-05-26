import 'package:flutter/material.dart';
//import 'package:transportation/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final Icon icon;
  final TextEditingController controller;
  const AppTextField({super.key, required this.hint, required this.icon, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hint,
        //labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none, // بدون خط
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
