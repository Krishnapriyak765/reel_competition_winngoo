import 'package:flutter/material.dart';

class ThemeListTile extends StatelessWidget {
  final String title;

  const ThemeListTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.check_circle_outline, color: Colors.red),
      title: Text(title),
      dense: true,
    );
  }
}
