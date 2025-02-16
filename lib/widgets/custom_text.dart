import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.textSize,
    required this.shadows,
  });

  final String text;
  final double textSize;
  final List<Shadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        shadows: shadows,
      ),
    );
  }
}
