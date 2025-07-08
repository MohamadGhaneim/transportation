import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transportation/communication/whatsapp_sender.dart';
import 'package:transportation/config/app_strings.dart';

class GetNumberManager {
  static Future<void> chatWhatsAppWithManager(
    BuildContext context,
    String message ,
    int tripID,
  ) async {
    try {
      final data = {"trip_id": tripID};

      final response = await http.post(
        Uri.parse(AppStrings.url_api_chat_manager),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (json["status"] == "success") {
          final phoneNumber = json["PHONE_NUMBER"];
          WhatsApp.openWhatsApp(phoneNumber, message);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Failed: ${json["message"]}")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
