import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:transportation/config/app_strings.dart';

Future<String?> createPaymentIntent(double amount) async {
  final url = Uri.parse(AppStrings.make_payment);
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'amount': amount}), 
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['clientSecret'];
  } else {
    print('Error: ${response.body}');
    return null;
  }
}
