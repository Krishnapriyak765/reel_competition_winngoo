import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reels_application/core/constants/app_colors.dart';
import 'package:reels_application/core/services/get_demo_video.dart';
import 'package:reels_application/data/models/demo_video.dart';
import 'package:reels_application/widgets/tab_floating_buttons.dart';
import 'package:reels_application/widgets/video_player_page.dart';

class DemoVideosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DemoVideo>>(
      future: fetchDemoVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('⚠️ Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No demo videos found.'));
        }

        final videos = snapshot.data!;
        return Column(
          children: [
            Text(
              'How to make it real videos',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: Appcolors.grey,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(video.title),
                      subtitle: Text(video.videoUrl),
                      trailing: Icon(
                        Icons.play_circle_fill,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    VideoPlayerScreen(videoUrl: video.videoUrl),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            TabFloatingButtons(),
          ],
        );
      },
    );
  }
}
