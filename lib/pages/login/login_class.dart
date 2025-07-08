import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int userId;
  final String email;
  final String phoneNumber;
  final int typeId;
  final String fullName;
  final String provider;
  final String path_photo;

  static User? currentUser;

  User({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.typeId,
    required this.fullName,
    required this.provider,
    required this.path_photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: int.tryParse(json['USER_ID']?.toString() ?? '0') ?? 0,
      email: json['USER_EMAIL'] ?? '',
      phoneNumber: json['PHONE_NUMBER'] ?? '',
      typeId: int.tryParse(json['TYPE_ID']?.toString() ?? '0') ?? 0,
      fullName: json['FULL_NAME'] ?? '',
      provider: json['provider'] ?? '',
      path_photo: json['path_photo'] ?? 'assets/images/user.png',
    );
  }

  static Future<void> saveUserToPrefs(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.userId);
    await prefs.setString('email', user.email);
    await prefs.setString('phoneNumber', user.phoneNumber);
    await prefs.setInt('typeId', user.typeId);
    await prefs.setString('fullName', user.fullName);
    await prefs.setString('provider', user.provider);
    await prefs.setString('path_photo', user.path_photo);
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<User?> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt('userId');
    final email = prefs.getString('email');
    final phoneNumber = prefs.getString('phoneNumber');
    final typeId = prefs.getInt('typeId');
    final fullName = prefs.getString('fullName');
    final provider = prefs.getString('provider');
    final path_photo =
        prefs.getString('path_photo') ?? 'assets/images/user.png';

    if (userId != null &&
        email != null &&
        phoneNumber != null &&
        typeId != null &&
        fullName != null &&
        provider != null) {
      return User(
        userId: userId,
        email: email,
        phoneNumber: phoneNumber,
        typeId: typeId,
        fullName: fullName,
        provider: provider,
        path_photo: path_photo,
      );
    }

    return null;
  }
}
