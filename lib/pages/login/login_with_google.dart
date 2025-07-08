// ignore_for_file: unused_element, unused_local_variable, use_build_context_synchronously, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/config/app_strings.dart';
import 'package:http/http.dart' as http;

final GoogleSignIn _googleSignIn = GoogleSignIn();

void handleSignIn(BuildContext context) async {
  try {
    ///////////================CHECK EMAIL
    final account = await _googleSignIn.signIn();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signed in: ${account?.displayName} , ${account?.email}'),
      ),
    );
    ///////////================SEND REQUEST
    final email = account?.email ?? '';
    final fullname = account?.displayName ?? '';

    if (email == '' || fullname == "") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Google account missing info.")));
    }
    final response = await http.post(
      Uri.parse(AppStrings.url_api_google_login),
      body: {'email': email, 'fullname': fullname},
    );

    if (response.statusCode == 200) {
      Navigator.of(
        context,
      ).pushReplacementNamed(AppRoutes.mainpage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Code: ${response.statusCode}, Body: ${response.body}"),
        ),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Code: ${response.statusCode}, Body: ${response.body}"),
        ),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(' $error')));
  }
}
