// ignore_for_file: non_constant_identifier_names

class BookClass {
  int userId;
  int tripId;
  int userLocation;
  int destinationLocation;

  DateTime departureDateTime;
  DateTime returnDateTime;
  DateTime paymentDate;
  double paymentAmount;

  BookClass({
    required this.userId,
    required this.tripId,
    required this.userLocation,
    required this.destinationLocation,
    required this.departureDateTime,
    required this.returnDateTime,
    required this.paymentDate,
    required this.paymentAmount,
  });

  Map<String, dynamic> toJson() => {
    'USER_ID': userId,
    'TRIP_ID': tripId,
    'USER_LOCATION': userLocation,
    'DESTINATION_LOCATION': destinationLocation,
    'DEPARTURE_DATE_TIME': departureDateTime.toIso8601String(),
    'RETURN_DATE_TIME': returnDateTime.toIso8601String(),
    'PAYMENT_DATE': paymentDate.toIso8601String(),
    'PAYMENT_AMOUNT': paymentAmount,
  };
}
