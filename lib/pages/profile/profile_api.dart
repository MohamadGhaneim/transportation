import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/config/app_strings.dart';
import 'package:transportation/pages/login/login_class.dart';
import 'package:transportation/validation/input_validation.dart';

class ProfileApi {
  static Future<void> updateProfile({
    required context,
    required String email,
    required String phoneNumber,
    required String fullName,
    required String path_photo,
  }) async {
    for (var element in [email, phoneNumber, fullName]) {
      if (element.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("All fields must be filled")));

        throw Exception("All fields must be filled");
      }
      if (InputValidation.cleanInput(element) != element) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid characters in input")));
        throw Exception("Invalid characters in input");
      }
    }

    final prefs = await SharedPreferences.getInstance();

    // await prefs.setString('email', email);
    // await prefs.setString('phoneNumber', phoneNumber);
    // await prefs.setString('fullName', fullName);

    if (User.currentUser != null) {
      User.currentUser = User(
        userId: User.currentUser!.userId,
        email: email,
        phoneNumber: phoneNumber,
        typeId: User.currentUser!.typeId,
        fullName: fullName,
        provider: User.currentUser!.provider,
        path_photo: User.currentUser!.path_photo,
      );
    }

    final userId = prefs.getInt('userId');
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User not logged in")));
      throw Exception("User not logged in");
    }

    final response = await http.post(
      Uri.parse(AppStrings.update_profile),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "email": email,
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "path_photo": path_photo,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile updated successfully"),
          backgroundColor: Colors.green,
        ),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      await prefs.setString("phoneNumber", phoneNumber);
      await prefs.setString("fullName", fullName);
      await prefs.setString("path_photo", path_photo);

      if (User.currentUser != null) {
        User.currentUser = User(
          userId: userId,
          email: email,
          phoneNumber: phoneNumber,
          typeId: User.currentUser!.typeId,
          fullName: fullName,
          provider: User.currentUser!.provider,
          path_photo: User.currentUser!.path_photo,
        );
      }
    } else {
      throw Exception("Failed to update profile: ${response.body}");
    }
  }
}
