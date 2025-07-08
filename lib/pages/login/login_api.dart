// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/config/app_strings.dart';
import 'package:transportation/pages/login/login_class.dart';
import 'package:transportation/pages/main/main_page.dart';
import 'package:transportation/pages/notification/generate_token.dart';

class LoginAPI {
  static Future<void> handleLogin({
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

      if (response.statusCode == 401) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("wrong Pass or Email")));
        return;
      }

      if (response.statusCode == 200) {
        // take json
        final jsonData = jsonDecode(response.body);
        await User.saveUserToPrefs(User.fromJson(jsonData));
        await FCMService.requestPermission();
        await FCMService.updateTokenIfNeeded(email);

        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);

        // for delete
        User.currentUser = User.fromJson(jsonData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login: Success"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainPage()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed : ${response.statusCode}")),
        );
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
      return;
    }
  }
}
