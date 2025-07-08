// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:transportation/styles/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor = AppColors.deepOrange,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () async {
          //ShowLoadingDialog.showLoadingDialog(context);
          try {
            onPressed();
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Login: ${e}")));
          } finally {
            // Navigator.of(context).pop();
          }
        },
        child: Text(text, style: TextStyle(fontSize: screenWidth * 0.045)),
      ),
    );
  }
}
