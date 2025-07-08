// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/config/app_strings.dart';
import 'package:transportation/pages/login/login_class.dart';

class BookApi {
  static void sendBookingData({
    required BuildContext context,
    required int trip_id,
    required String userLocation,
    required String destinationLocation,
    required double payment,
  }) async {
    try {
      User? user = await User.loadUserFromPrefs();
      if (user == null) {
        Navigator.pushNamed(context, AppRoutes.login);
        return;
      }
      final Map<String, dynamic> data = {
        "TRIP_ID": trip_id.toString(),
        "USER_ID": user.userId,
        "USER_LOCATION": userLocation,
        "DESTINATION_LOCATION": destinationLocation,
        "payment": payment,
      };

      final response = await http.post(
        Uri.parse(AppStrings.url_api_booking),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Booking ${response.body}")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to send booking: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
