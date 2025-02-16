import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isReadonly = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isReadonly;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: isReadonly,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          filled: true,
        ),
      ),
    );
  }
}
