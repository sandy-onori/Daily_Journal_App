import 'package:flutter/material.dart';

import '../utils/pallete.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      style: const TextStyle(color: Pallete.dark, fontSize: 17),
      cursorColor: Pallete.dark,
      decoration: InputDecoration(
        fillColor: Pallete.white2,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Pallete.darkHint,
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Pallete.accent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
