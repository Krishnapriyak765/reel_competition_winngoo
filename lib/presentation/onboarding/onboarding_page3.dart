import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reels_application/widgets/dancing_image_page.dart';

class ReelFunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),

            // Illustration
            Center(child: DancingImagePage(val: 3)),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_dot(false), _dot(false), _dot(true)],
            ),

            // Text
            Column(
              children: [
                const Text(
                  "Join The Reel Fun",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Sign Up And Start Your Journey To Endless\nEntertainment",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed('CompetitionPage');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CompetitionPage(),
                      //   ),
                      // );
                    },
                    child: Text("About the Competition"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Color(0xff2b21f3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      context.pushNamed('register');

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CreateAccountPage(),
                      //   ),
                      // );
                    },
                    child: Text("Register"),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      foregroundColor: Color(0xff2b21f3),
                      side: BorderSide(color: Color(0xff2b21f3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      context.pushNamed('login');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginPage()),
                      // );
                    },
                    child: Text("Login"),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      foregroundColor: Color(0xff2b21f3),
                      side: BorderSide(color: Color(0xff2b21f3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
        shape: BoxShape.circle,
        color: isActive ? Colors.blue : Colors.grey.shade300,
      ),
    );
  }
}
