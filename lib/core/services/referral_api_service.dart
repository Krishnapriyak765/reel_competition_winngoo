import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reels_application/data/models/referral_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // static const String token =
  //     '17|gRQSv5Av1Wt11QnbdDr2u5BKcwqmXLE1KS4XegQv221584e0';

  static Future<Referral?> getReferralData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('https://winngooreels.wimbgo.com/api/user/referrals');
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    print("Referral API response: ${response.body}");

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      print("Refferal API sucess${jsonBody['data']}");

      return Referral.fromJson(jsonBody['data']);
    } else {
      print("Referral API failed: ${response.statusCode}");
      return null;
    }
  }
}
