import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleMapsLinkGenerator {
  static const String _apiKey = 'AIzaSyDw2KEIvZm7ALfuiPH9xvIQftCRg9JUeeI';
  static const String _geminiUrl =
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=$_apiKey';

  static Future<String?> generateRouteLink({
    required String origin,
    required String destination,
    required List<String> waypoints,
  }) async {
    //     final prompt = '''
    // You are a routing assistant. Please generate a direct Google Maps URL that:

    // - Starts from: $origin
    // - Ends at: $destination
    // - Includes these coordinates as waypoints (pickup locations): ${waypoints.join('; ')}

    // * Only return the direct Google Maps link *
    // Do not include any explanation or extra text.
    // Do not add quotes or formatting.

    // Make sure the link has all stops ordered optimally (if possible) for driving.
    // ''';

    final prompt = '''
Generate a direct Google Maps link that starts at "$origin" and ends at "$destination". The bus must pick up students at the following coordinates in the best possible order: ${waypoints.join(', ')}. Return only the final Google Maps URL.

''';

    final response = await http.post(
      Uri.parse(_geminiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print('Gemini Link: ${response.body}');
      final text = body['candidates']?[0]?['content']?['parts']?[0]?['text'];

      if (text != null) {
        final linkMatch = RegExp(
          r'(https:\/\/www\.google\.com\/maps[^\s]+)',
        ).firstMatch(text);
        if (linkMatch != null) {
          return linkMatch.group(0); // هذا هو الرابط الفعلي
        } else {
          print('No link found in Gemini response: $text');
          return null;
        }
      }
    } else {
      print('Gemini Error: ${response.body}');
      return null;
    }
    return null;
  }
}
