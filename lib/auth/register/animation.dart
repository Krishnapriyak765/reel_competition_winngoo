import 'package:flutter/material.dart';
import 'package:reels_application/auth/login/login_page.dart';

class Animationscreen extends StatefulWidget {
  const Animationscreen({Key? key}) : super(key: key);

  @override
  State<Animationscreen> createState() => _AnimationscreenState();
}

class _AnimationscreenState extends State<Animationscreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Paid successfully"),
              Center(
                child: Image(
                  image: NetworkImage(
                    "https://th.bing.com/th/id/R.779b9dc3928c2dbc304bcf6702bef6df?rik=YcBZULcBaENJ%2bA&riu=http%3a%2f%2fwww.clipartbest.com%2fcliparts%2fxig%2f67a%2fxig67ak5T.gif&ehk=nEkxZPycTq5aonhibetdIGtbEyVfNPMLT0nhCiz1DSg%3d&risl=&pid=ImgRaw&r=0",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
