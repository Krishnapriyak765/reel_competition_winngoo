import 'package:flutter/material.dart';
import 'package:reels_application/presentation/onboarding/onboarding_page3.dart';
import 'package:reels_application/widgets/dancing_image_page.dart';

// void main() {
//   runApp(MaterialApp(
//     home: OnboardingPage(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back arrow
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back),
              ),

              // Illustration
              DancingImagePage(val: 2),
              // Page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_dot(false), _dot(true), _dot(false)],
              ),

              // Text Content
              Column(
                children: [
                  Text(
                    "Go Viral, Stay Social",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff010a1a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Like,Comment,And Share Reels with Your Squard In Just One Tap",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // Buttons (Skip + Next)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReelFunPage()),
                      );
                    },
                    child: Text("Skip"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xff2b21f3),
                      side: BorderSide(color: Color(0xff2b21f3)),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReelFunPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2b21f3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(14),
                    ),
                    child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
