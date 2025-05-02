import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  final String baseUrl = 'https://winngooreels.wimbgo.com/api';

  Future<bool> submitReview(final int rating, final String review) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('$baseUrl/user/reviews');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'rating': rating, 'review': review}),
    );
    log(response.body);

    return response.statusCode == 200;
  }
}
