import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_strings.dart';
import 'package:transportation/pages/login/login_class.dart';

class EditBookApi {
  static void updateBookingData({
    required BuildContext context,
    required int trip_id,
    required String userLocation,
    required String destinationLocation,
  }) async {
    final Map<String, dynamic> data = {
      "TRIP_ID": trip_id.toString(),
      "USER_ID": User.currentUser!.userId,
      "USER_LOCATION": userLocation,
      "DESTINATION_LOCATION": destinationLocation,
    };
    try {
      final response = await http.put(
        Uri.parse(AppStrings.url_api_update_booking),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Update successful"),
            backgroundColor: Colors.green,
          ),
        );
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Faild: $e")));
    }
  }

  static void deleteBooking({
    required BuildContext context,
    required int trip_id,
  }) async {
    // cfreate instance of sheard preferences
    try {
      final response = await http.post(
        Uri.parse(AppStrings.cancel_booking),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "TRIP_ID": trip_id,
          "USER_ID": User.currentUser!.userId,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Delete successful"),
            backgroundColor: Colors.green,
          ),
        );
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Faild : $e")));
    }
  }
}
