import 'package:daily_journal/utils/pallete.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  // The hint text displayed in the text field
  final String hintText;
  // Controller for managing the text input
  final TextEditingController controller;
  // Indicates if the text field should obscure the input (for passwords)
  final bool isObscured;
  // Optional label text displayed above the text field
  final String? labelText;

  const LoginField({
    super.key,
    required this.hintText,
    required this.controller,
    this.labelText,
    this.isObscured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display label text if provided
        labelText != null
            ? Text(
                labelText!,
                style: const TextStyle(
                  color: Pallete.dark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox(), // Empty space if no label text
        const SizedBox(height: 8), // Space between label and text field
        SizedBox(
          width: double.infinity, // Full width for the text field
          child: TextFormField(
            controller: controller, // Text editing controller
            obscureText: isObscured, // Obscure text if true
            style: const TextStyle(color: Pallete.dark, fontSize: 17),
            cursorColor: Pallete.dark, // Cursor color
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Padding inside the text field
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Pallete.dark, // Border color when enabled
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Pallete.dark, // Border color when focused
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              hintText: hintText, // Hint text for the text field
              hintStyle: const TextStyle(
                color: Pallete.white2, // Hint text color
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
