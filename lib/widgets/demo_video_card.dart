import 'package:flutter/material.dart';

class DemoVideoCard extends StatelessWidget {
  final String thumbnailUrl;
  final VoidCallback onTap;

  const DemoVideoCard({
    super.key,
    required this.thumbnailUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(thumbnailUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000), // Light shadow
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
        ),
      ),
    );
  }
}
