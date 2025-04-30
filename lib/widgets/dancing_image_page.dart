import 'package:flutter/material.dart';

class DancingImagePage extends StatefulWidget {
  final int val;
  const DancingImagePage({super.key, required this.val});

  @override
  _DancingImagePageState createState() => _DancingImagePageState();
}

class _DancingImagePageState extends State<DancingImagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation back and forth

    _animation = Tween<double>(
      begin: 0,
      end: 30,
    ).animate(_controller); // Move 30 pixels
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value), // Translate vertically
          child: Image.asset(
            'assets/images/page${widget.val}.png',
            height: 250,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
