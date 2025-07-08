import 'package:flutter/material.dart';
import 'package:transportation/styles/app_colors.dart';

class ShowLoadingDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.lightOrange,
          elevation: 0,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
