import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:transportation/config/app_strings.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> requestPermission() async {
    await _messaging.requestPermission();
  }

  static Future<String?> getToken() async {
    try {
      String? token = await _messaging.getToken();
      print("📱 FCM Token: $token");
      return token;
    } catch (e) {
      print("❌ Error getting token: $e");
      return null;
    }
  }

  static Future<void> updateTokenIfNeeded(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final oldToken = prefs.getString("fcm_token");
    final newToken = await getToken();

    if (newToken != null && newToken != oldToken) {
      try {
        final response = await http.post(
          Uri.parse(AppStrings.set_token),
          body: {
            "USER_EMAIL": email,
            "fcm_token": newToken,
          },
        );

        if (response.statusCode == 200) {
          print("✅ Token updated on server");
          prefs.setString("fcm_token", newToken);
        } else {
          print("❌ Server error: ${response.statusCode}");
        }
      } catch (e) {
        print("❌ Failed to send token: $e");
      }
    } else {
      print("🔄 Token unchanged");
    }
  }
}
