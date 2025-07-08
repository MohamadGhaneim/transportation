import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onPress;
  final IconData icon;
  final Color? btnColor;

  const AppIconButton({
    super.key,
    required this.onPress,
    required this.icon,
    this.btnColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Icon(icon, color: Colors.black, size: 30),
      ),
    );
  }
}
