import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_strings.dart';
import 'package:transportation/pages/driver_trip_details/booked_user_model.dart';

class TripDetailsAPI {
  static Future<List<BookedUser>> fetchBookedUsers(int tripId) async {
    final response = await http.post(
      Uri.parse(AppStrings.get_trips_detailes),
      body: {'trip_id': tripId.toString()},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BookedUser.fromJson(json)).toList();
    } else {
      print('TripDetailsAPI Error: ${response.body}');
      throw Exception('Failed to fetch booked users for trip $tripId');
    }
  }
}
