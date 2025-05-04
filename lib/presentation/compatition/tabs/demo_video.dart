import 'package:flutter/material.dart';

class DemoVideosTab extends StatelessWidget {
  const DemoVideosTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with dynamic video list from API
    final List<String> demoVideoUrls = [
      'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
      'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: demoVideoUrls.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return DemoVideoCard(
          videoUrl: demoVideoUrls[index],
          thumbnailUrl: '',
          onTap: () {},
        );
      },
    );
  }
}

class DemoVideoCard extends StatelessWidget {
  final String videoUrl;

  const DemoVideoCard({
    super.key,
    required this.videoUrl,
    required String thumbnailUrl,
    required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(Icons.play_circle_fill, color: Colors.white, size: 50),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:reels_application/core/constants/app_colors.dart';
// import 'package:reels_application/core/services/get_demo_video.dart';
// import 'package:reels_application/data/models/demo_video.dart';
// import 'package:reels_application/widgets/tab_floating_buttons.dart';
// import 'package:reels_application/widgets/video_player_page.dart';

// class DemoVideosTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<DemoVideo>>(
//       future: fetchDemoVideos(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('⚠️ Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No demo videos found.'));
//         }

//         final videos = snapshot.data!;
//         return Column(
//           children: [
//             Text(
//               'How to make it real videos',
//               style: GoogleFonts.inter(
//                 fontWeight: FontWeight.bold,
//                 color: Appcolors.grey,
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.all(16),
//                 itemCount: videos.length,
//                 itemBuilder: (context, index) {
//                   final video = videos[index];
//                   return Card(
//                     elevation: 2,
//                     margin: EdgeInsets.only(bottom: 12),
//                     child: ListTile(
//                       title: Text(video.title),
//                       subtitle: Text(video.videoUrl),
//                       trailing: Icon(
//                         Icons.play_circle_fill,
//                         color: Colors.blue,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (_) =>
//                                     VideoPlayerScreen(videoUrl: video.videoUrl),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             TabFloatingButtons(),
//           ],
//         );
//       },
//     );
//   }
// }
