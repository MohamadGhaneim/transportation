// ignore_for_file: non_constant_identifier_names

class BookedUser {
  final int bookId;
  final int userId;
  final String userLocation;
  final String destinationLocation;
  final double payment;
  final bool checkPay;
  final String userEmail;
  final String fullName;
  final String phoneNumber;
  final String userPhoto;

  BookedUser({
    required this.bookId,
    required this.userId,
    required this.userLocation,
    required this.destinationLocation,
    required this.payment,
    required this.checkPay,
    required this.userEmail,
    required this.fullName,
    required this.phoneNumber,
    required this.userPhoto,
  });

  factory BookedUser.fromJson(Map<String, dynamic> json) {
    return BookedUser(
      bookId: int.parse(json['BOOK_ID'].toString()),
      userId: int.parse(json['USER_ID'].toString()),
      userLocation: json['USER_LOCATION'].toString(),
      destinationLocation: json['DESTINATION_LOCATION'].toString(),
      payment: double.parse(json['PAYMENT'].toString()),
      checkPay: json['CHECK_PAY'].toString() == "1",
      userEmail: json['USER_EMAIL'].toString(),
      fullName: json['FULL_NAME'].toString(),
      phoneNumber: json['PHONE_NUMBER'].toString(),
      userPhoto: json['USER_PHOTO'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BOOK_ID': bookId,
      'USER_ID': userId,
      'USER_LOCATION': userLocation,
      'DESTINATION_LOCATION': destinationLocation,
      'PAYMENT': payment,
      'CHECK_PAY': checkPay ? 1 : 0,
      'USER_EMAIL': userEmail,
      'FULL_NAME': fullName,
      'PHONE_NUMBER': phoneNumber,
      'USER_PHOTO': userPhoto,
    };
  }
}
