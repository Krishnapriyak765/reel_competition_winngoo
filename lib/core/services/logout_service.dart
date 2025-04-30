import 'dart:io';
import 'package:reels_application/core/services/upload_video_servide.dart';
import 'package:reels_application/data/models/upload_video_model.dart';

class UploadRepository {
  final UploadDataSource dataSource;

  UploadRepository(this.dataSource);

  Future<UploadResponse> upload(File video) {
    return dataSource.uploadVideo(video);
  }

  Future<bool> logout() {
    return dataSource.logoutUser();
  }
}
