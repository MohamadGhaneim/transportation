// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:transportation/validation/Validator.dart';

class CleanInput extends IValidate {
  @override
  bool validate(String input) {
    String cleanInput = input.replaceAll(RegExp(r'[^a-zA-Z0-9.@ ]'), '');
    if (cleanInput == input) {
      return true;
    }
    return false;
  }
}

class InputValidation {
  static String cleanInput(String input) {
    return input.replaceAll(RegExp(r'[^a-zA-Z0-9.@ ]'), '');
  }

  static String cleanPhoneNumber(String input) {
    return input.replaceAll(RegExp(r'[^0-9+]'), '');
  }

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String RandomPassword() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@\$&';
    var random = Random();
    var result = '';
    int lenth_password = 6 + random.nextInt(4);
    for (int i = 0; i < lenth_password; i++) {
      result += chars[random.nextInt(chars.length)];
    }
    return result;
  }

  static void CleanInput(TextEditingController inputController) {
    inputController.text = "";
  }

  static bool isValidLocation(String inputLocation) {
    final regex = RegExp(r'^\s*-?\d{1,3}\.\d+,\s*-?\d{1,3}\.\d+\s*$');
    return regex.hasMatch(inputLocation);
  }

  static bool validateBookingFields({
    required BuildContext context,
    required TextEditingController userLocation,
    required String? selectedDestination,
  }) {
    // Location validation
    final location = userLocation.text.trim();
    if (location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your location')),
      );
      return false;
    }
    if (!isValidLocation(location)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid location format. Example: 33.13, 35.45'),
        ),
      );
      return false;
    }

    // Destination validation
    if (selectedDestination == null || selectedDestination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a destination')),
      );
      return false;
    }

    return true;
  }
}
