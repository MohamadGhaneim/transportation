// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_strings.dart';

Future<void> SendEmail({
  required BuildContext context,
  required String toEmail,
  required String newpassword,
  required String newhashpassword,
}) async {
  final url = Uri.parse(AppStrings.url_api_sendEmail);

  if (toEmail.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Email is required")));
    return;
  }
  final response = await http.post(
    url,
    body: {
      'to': toEmail,
      'newpassword': newpassword,
      'newhashpassword': newhashpassword,
    },
  );
  if (response.statusCode == 401) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("your Email is not exist")));
    return;
  }
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Check your Email")));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to send email: ${response.body}')),
    );
  }
}
