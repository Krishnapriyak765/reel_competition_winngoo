import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reels_application/core/constants/app_colors.dart';

class CompetitionRulesPage extends StatelessWidget {
  const CompetitionRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Appcolors.white,
      appBar: AppBar(
        backgroundColor: Appcolors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Appcolors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Competition Rules",
          style: GoogleFonts.inter(
            color: Appcolors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Join Winngoo’s First-Ever Reel Competition! 🎥\nShow off your creativity by making a fun reel featuring Winngoo UK & Winngoo Pages and win amazing prizes!",
                style: GoogleFonts.inter(height: 1.5),
              ),
              const SizedBox(height: 16),
              Text("✅ Competition Details:", style: GoogleFonts.inter()),
              const SizedBox(height: 8),
              ruleItem(" Open worldwide (Ages 18+)"),
              ruleItem(" Reel Duration: 40-60 seconds"),
              ruleItem(
                " Family-friendly & original content (No copyrighted material)",
              ),
              ruleItem(" Entry Fee: \$15 (Non-refundable)"),
              ruleItem(" Competition Dates: [Start Date] – [End Date]"),
              ruleItem(
                " UK winners attend an offline event, International winners receive prizes by mail.",
              ),
              ruleItem(" Bonus: Refer friends and earn extra points!"),
              ruleItem(
                " Showcase your creativity & stand a chance to win big!",
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "By entering, you agree to Winngoo using your reel for promotions.",
                      style: GoogleFonts.inter(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ruleItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: GoogleFonts.inter(height: 1.5))),
        ],
      ),
    );
  }
}
