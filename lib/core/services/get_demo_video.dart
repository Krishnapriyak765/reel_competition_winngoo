// lib/core/services/get_video_service.dart

import 'package:reels_application/data/models/demo_video.dart';
import 'package:reels_application/data/models/user_get_video.dart';

Future<List<DemoVideo>> fetchDemoVideos() async {
  await Future.delayed(Duration(seconds: 1)); // simulate a small delay

  return [
    DemoVideo(
      title: "Official Winngoo Reels Tutorial",
      videoUrl: "https://www.youtube.com/watch?v=R3GfuzLMPkA",
    ),
    // You can add more videos here if needed
  ];
}
