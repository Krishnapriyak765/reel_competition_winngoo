import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reels_application/data/models/review_model.dart';

class ReviewService {
  final String baseUrl = 'https://winngooreels.wimbgo.com/api';

  Future<bool> submitReview(String token, Review review) async {
    final url = Uri.parse('$baseUrl/user/reviews');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(review.toJson()),
    );

    return response.statusCode == 200;
  }
}
