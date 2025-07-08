// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transportation/pages/main/main_page.dart';
import 'package:transportation/styles/app_colors.dart';

class BottomNavigationItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final int index;
  const BottomNavigationItem({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      focusColor: AppColors.lightOrange,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        height: 28,
        width: 28,
        icon,
        colorFilter: ColorFilter.mode(
          currentindex == index ? Colors.black : Colors.black.withOpacity(0.3),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
