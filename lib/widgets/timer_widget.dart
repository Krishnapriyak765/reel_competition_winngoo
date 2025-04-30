// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CompetitionTimerWidget extends StatefulWidget {
//   final String remainingTimeText;

//   CompetitionTimerWidget({required this.remainingTimeText});

//   @override
//   _CompetitionTimerWidgetState createState() => _CompetitionTimerWidgetState();
// }

// class _CompetitionTimerWidgetState extends State<CompetitionTimerWidget> {
//   late int remainingSeconds;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     remainingSeconds = parseRemainingTime(widget.remainingTimeText);
//     startTimer();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (_) {
//       if (remainingSeconds > 0) {
//         setState(() {
//           remainingSeconds--;
//         });
//       } else {
//         _timer?.cancel();
//       }
//     });
//   }

//   int parseRemainingTime(String timeString) {
//     final regex = RegExp(r'(\d+)h\s+(\d+)m\s+(\d+)s');
//     final match = regex.firstMatch(timeString);
//     if (match != null) {
//       final hours = int.parse(match.group(1)!);
//       final minutes = int.parse(match.group(2)!);
//       final seconds = int.parse(match.group(3)!);
//       return hours * 3600 + minutes * 60 + seconds;
//     }
//     return 0;
//   }

//   String formatTime(int seconds) {
//     final h = seconds ~/ 3600;
//     final m = (seconds % 3600) ~/ 60;
//     final s = seconds % 60;
//     return "$h h $m m $s s";
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       "Time: ${formatTime(remainingSeconds)}",
//       style: GoogleFonts.inter(
//         color: Colors.red,
//         fontSize: 13,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }
