import 'package:flutter/material.dart';
import 'package:transportation/styles/app_colors.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  const Toolbar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: actions,
      elevation: 10,
      backgroundColor: AppColors.lightOrange,
    );
  }

  /// we should add const Size.fromHeight(64) the height of appbar
  @override
  Size get preferredSize => const Size.fromHeight(64);
}
