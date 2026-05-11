import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;

  final bool obscureText;

  final TextEditingController? controller;

  final TextInputType keyboardType;

  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,

      decoration: InputDecoration(hintText: hintText, prefixIcon: prefixIcon),
    );
  }
}
