import 'package:flutter/material.dart';

///import 'package:transportation/config/app_icons.dart';

class UserAvatar extends StatelessWidget {
  final double height;
  final double width;
  final String? img;
  const UserAvatar({super.key, this.height = 90, this.width = 90, this.img});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(26)),
      child: Image.asset(
        img ?? "assets/images/user.png",
        height: height,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
