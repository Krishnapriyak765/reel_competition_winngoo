import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> fetchPrivacyPolicy() async {
  final url = Uri.parse('https://winngooreels.wimbgo.com/api/privacy');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming the privacy policy is a string or part of a field like `data['content']`
      return data.toString(); // Replace with `data['content']` if needed
    } else {
      print('Failed to load privacy policy: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching privacy policy: $e');
    return null;
  }
}

void fetchTermsConditions() async {
  final url = Uri.parse("https://winngooreels.wimbgo.com/api/terms-conditions");

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('Terms: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching terms and conditions: $e');
  }
}
