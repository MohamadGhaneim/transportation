// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/config/app_strings.dart';

class LoginAPI {
  static void handleLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email and password are required")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(AppStrings.url_api_login),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login: ${response.body}")));
        Navigator.of(context).pushNamed(AppRoutes.signup);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
