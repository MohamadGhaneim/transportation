// ignore_for_file: constant_identifier_names

import 'package:transportation/pages/login/login_page.dart';
import 'package:transportation/pages/signup/signup_page.dart';

class AppRoutes {
  static final pages = {
    AppRoutes.login: (context) => LoginPage(),
    AppRoutes.signup: (context) => SignupPage(),
  };
  static const login = '/';
  static const signup = '/signup';
}
