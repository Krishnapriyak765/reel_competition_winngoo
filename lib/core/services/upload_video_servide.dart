import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reels_application/data/models/upload_video_model.dart';

class UploadDataSource {
  final String baseUrl = "https://winngooreels.wimbgo.com/api";
  final String token = "3|B9LLG7y7ISsYcaDmBWEQR6iKbVv4jsmiiaNQJAeA5dc141af";

  Future<UploadResponse> uploadVideo(File video) async {
    try {
      final uri = Uri.parse("$baseUrl/user/upload-video");
      final request =
          http.MultipartRequest("POST", uri)
            ..headers['Authorization'] = 'Bearer $token'
            ..files.add(await http.MultipartFile.fromPath('video', video.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        return UploadResponse(success: true);
      } else {
        return UploadResponse(success: false, message: 'Upload failed');
      }
    } catch (e) {
      return UploadResponse(success: false, message: e.toString());
    }
  }

  Future<bool> logoutUser() async {
    try {
      final uri = Uri.parse("$baseUrl/user/logout");
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
