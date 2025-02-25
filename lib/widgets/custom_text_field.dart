import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.color,
    this.keyboardType,
    this.inputFormatters, // Added inputFormatters
  });

  final TextEditingController controller;
  final String hintText;
  final Color color;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters; // Nullable inputFormatters

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: color,
      inputFormatters: inputFormatters, // Apply inputFormatters if provided
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hintText,
      ),
    );
  }
}
