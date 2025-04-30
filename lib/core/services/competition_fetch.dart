import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reels_application/data/models/competition_model.dart';

Future<Competition?> fetchCompetitionData() async {
  final response = await http.get(
    Uri.parse('https://winngooreels.wimbgo.com/api/competitions'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    final competitions = jsonResponse['competitions'];
    if (competitions != null &&
        competitions is List &&
        competitions.isNotEmpty) {
      return Competition.fromJson(competitions[0]);
    } else {
      print("No competitions found");
      return null;
    }
  } else {
    throw Exception('Failed to load competition data');
  }
}
