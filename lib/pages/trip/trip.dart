// ignore_for_file: non_constant_identifier_names

class Trip {
  final int TripId;
  final int ManagerId;
  final String tripDate;
  final String departureTime;
  final String returnTime;
  final double seatPrice;
  final String status;
  final String destination_location;
  final String departure_location;
  final String departure_coords; 
  final List<String> specificLocations;

  Trip({
    required this.TripId,
    required this.destination_location,
    required this.departure_location,
    required this.departure_coords,
    required this.ManagerId,
    required this.tripDate,
    required this.departureTime,
    required this.returnTime,
    required this.seatPrice,
    required this.status,
    required this.specificLocations,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      TripId: int.parse(json['TRIP_ID'].toString()),
      ManagerId: int.parse(json['MANAGER_ID'].toString() ),
      tripDate: json['TRIP_DATE'].toString(),
      departureTime: json['DEPARTURE_TIME'].toString(),
      returnTime: json['RETURN_TIME'].toString(),
      seatPrice: double.parse(json['SEAT_PRICE'].toString()),
      status: json['STATUS_TRIP'].toString(),
      destination_location: json['DESTINATION_LOCATION'].toString(),
      departure_location: json['DEPARTURE_LOCATION'].toString(),
      departure_coords: json['DEPARTURE_COORDS'].toString(),
      specificLocations: List<String>.from(json['SPECIFIC_LOCATIONS'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TRIP_ID': TripId,
      'MANAGER_ID': ManagerId,
      'TRIP_DATE': tripDate,
      'DEPARTURE_TIME': departureTime,
      'RETURN_TIME': returnTime,
      'SEAT_PRICE': seatPrice,
      'STATUS_TRIP': status,
      'DESTINATION_LOCATION': destination_location,
      'DEPARTURE_LOCATION': departure_location,
      'DEPARTURE_COORDS': departure_coords,
      'SPECIFIC_LOCATIONS': specificLocations,
    };
  }
}
