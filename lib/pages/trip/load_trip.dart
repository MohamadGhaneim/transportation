// ignore_for_file: non_constant_identifier_names

import 'package:transportation/pages/trip/fetch_trip.dart';
import 'package:transportation/pages/trip/trip.dart';

class LoadTrip {
  static Future<List<Trip>> tripsFuture = FetchTrip().fetchTrips();

  static Future<List<Trip>> fetchTrips() {
    tripsFuture = FetchTrip().fetchTrips();
    return tripsFuture;
  }
}
