import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton({super.key , required this.onPressed , required this.title});
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 22 , horizontal: 100)
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: Colors.white),
      ),
    );
  }
}