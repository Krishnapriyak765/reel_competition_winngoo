import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reels_application/core/constants/app_colors.dart';
import 'package:reels_application/core/services/review_service.dart';
import 'package:reels_application/main.dart';

class ReviewDialog extends StatefulWidget {
  final VoidCallback onClose;

  const ReviewDialog({super.key, required this.onClose});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double rating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool isSubmitting = false;

  Future<void> _submitReview() async {
    setState(() {
      isSubmitting = true;
      print('$rating+RATING IS $_commentController');
    });

    final reviewService = ReviewService();
    final success = await reviewService.submitReview(
      rating.toInt(),
      _commentController.text,
    );

    setState(() => isSubmitting = false);

    if (success) {
      print('Sucessssssssssssssssssssssssssssssssssssssss');
      Navigator.pop(context);
      widget.onClose();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thank you for your feedback!")),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to submit review")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: screenHeight * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade200,
          // const Color(0xFF82AFFF),
        ),
        child: Column(
          spacing: 4.2,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Leave Your Review",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Appcolors.white,
                ),
              ),
            ),
            RatingBar.builder(
              itemPadding: EdgeInsets.all(0.5),
              initialRating: rating,
              minRating: 1,
              allowHalfRating: false,
              itemCount: 5,
              itemBuilder:
                  (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (r) => setState(() => rating = r),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Leave Your Comment",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Appcolors.white,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: screenwidth * 0.65,
              child: TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Type here...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: screenHeight * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.secondaryYellow,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: isSubmitting ? null : _submitReview,
                child: Text(
                  isSubmitting ? "Submitting..." : "Submit",
                  style: GoogleFonts.inter(
                    color: Appcolors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
