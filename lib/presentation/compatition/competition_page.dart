import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reels_application/core/constants/app_colors.dart';
import 'package:reels_application/core/services/competition_fetch.dart';
import 'package:reels_application/data/models/competition_model.dart';
import 'package:reels_application/presentation/compatition/tabs/about_tab.dart';
import 'package:reels_application/presentation/compatition/tabs/demo_video.dart';
import 'package:reels_application/presentation/compatition/tabs/rules_guidelines.dart';
import 'package:reels_application/widgets/carousel_slider.dart';

class CompetitionPage extends StatefulWidget {
  @override
  State<CompetitionPage> createState() => _CompetitionPageState();
}

class _CompetitionPageState extends State<CompetitionPage> {
  Competition? competition;

  @override
  void initState() {
    super.initState();
    loadCompetition();
  }

  void loadCompetition() async {
    try {
      final result = await fetchCompetitionData();
      setState(() {
        competition = result;
      });
    } catch (e) {
      print("Error loading competition: $e");
    }
  }

  String getFormattedTime(int totalSeconds) {
    final minutes = (totalSeconds / 60).floor();
    return "$totalSeconds sec / $minutes mins";
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Competition",
            style: GoogleFonts.inter(
              color: Appcolors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF407BFF),
                  Color(0xFF0B296D),
                  // Color(0xFF0F4A86),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(height: screenHeight * 0.23, child: CarouselSliders()),

            /// 👉 This is the row you asked for
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    competition != null
                        ? "Time: ${competition!.remainingTime}"
                        : "Time: ...",
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    competition != null
                        ? "End Date: ${competition!.created_at}"
                        : "End Date: ...",
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,

                borderRadius: BorderRadius.circular(32),
              ),
              child: TabBar(
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                indicator: BoxDecoration(
                  color: Appcolors.primaryColor,
                  borderRadius: BorderRadius.circular(34),
                ),
                dividerHeight: 0,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: "   About   "),
                  Tab(text: "Demo videos"),
                  Tab(text: "Rules & Guidelines"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: TabBarView(
                children: [
                  AboutTab(),
                  DemoVideosTab(),
                  RulesAndGuidelinesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
