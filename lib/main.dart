import 'package:flutter/material.dart';
import 'package:transportation/config/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.pages,
    );
  }
}
