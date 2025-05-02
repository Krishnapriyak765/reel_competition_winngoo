import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reels_application/core/constants/app_colors.dart';

class TabFloatingButtons extends StatelessWidget {
  TabFloatingButtons({super.key});

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 280,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _popupRow(Icons.email, "no-reply@winngoomafee.co.uk"),
                    _popupRow(Icons.call, "02036756250"),
                    _popupRow(Icons.web, "www.winngoo.co.uk"),
                    _popupRow(Icons.location_on, "London"),
                    _popupRow(Icons.access_time, "10.00am - 5.00pm"),
                    _popupRow(Icons.calendar_month, "2025-03-17"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showUpcomingEventsDialog(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (ctx) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 260,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.1,
                      child: Image.asset(
                        "assets/images/upcoming_event.png",
                        height: 60,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Upcoming Competitions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    _popupRow(Icons.calendar_today, "March 17, 2025"),
                    _popupRow(
                      Icons.hourglass_bottom,
                      "Deadline: April 30, 2025",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _popupRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => _showContactDialog(context),
                  style: _buttonStyle,
                  child: Text(
                    "Contact Details",
                    style: GoogleFonts.inter(color: Appcolors.primaryColor),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _showUpcomingEventsDialog(context),
                  style: _buttonStyle,
                  child: Text(
                    "Upcoming Events",
                    style: GoogleFonts.inter(color: Appcolors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              context.pushNamed('register');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(160, 50),
              maximumSize: const Size(160, 50),
              backgroundColor: Appcolors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Enter Now",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Appcolors.white),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 45),
    backgroundColor: Appcolors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: Appcolors.primaryColor),
    ),
  );
}
