// user_bookings_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_strings.dart';
import '../trip/trip.dart';

class UserBookingsApi {
  static Future<List<Trip>> fetchUserBookings(int userId) async {
    final response = await http.post(
      Uri.parse(AppStrings.get_user_bookings),
      body: {'user_id': userId.toString()},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Trip.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load bookings for user $userId: ${response.statusCode}',
      );
    }
  }
}
