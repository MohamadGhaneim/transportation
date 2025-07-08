import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_strings.dart';
import 'package:transportation/pages/trip/trip.dart';

class FetchTrip {
    Future<List<Trip>> fetchTrips() async {
    final response = await http.get(
      Uri.parse(AppStrings.url_api_fetchTrip) ,
      //  headers: {
      //   "User-Agent": "Mozilla/5.0 (Mobile; Flutter App)",
      //   "Accept": "application/json",
      //  }
    );
    print("Response status: ${response.statusCode}");
  print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      //print(data.map((json) => Trip.fromJson(json)).toList());
      return data.map((json) => Trip.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trips');
    }
  }
}
