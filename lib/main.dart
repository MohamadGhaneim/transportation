import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Stripe.publishableKey='pk_test_51RfnohFojX3lXg5TJhHhWP8wEa8UtfQuXuU5sq3bzvGqfvLwcSQchh5NroWWID53UOQL4lBlfonQQVdcmXiCuED300Vo2gvhmB';// for payment

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: isLoggedIn ? AppRoutes.mainpage : AppRoutes.login,
      routes: AppRoutes.pages,
    );
  }
}
