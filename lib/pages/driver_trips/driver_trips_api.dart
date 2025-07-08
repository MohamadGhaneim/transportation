import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_strings.dart';
import 'package:transportation/pages/trip/trip.dart';

class TripService {
  static Future<List<Trip>> fetchDriverTrips(int driverId) async {
    final response = await http.post(
      Uri.parse(AppStrings.get_driver_trips),
      body: {'driver_id': driverId.toString()},
    );
    print("Response status: ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print('Response body: ${response.body}');
      return data.map((json) => Trip.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trips');
    }
  }
}
