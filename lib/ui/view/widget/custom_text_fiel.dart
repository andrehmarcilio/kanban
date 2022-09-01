import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.onChanged,
      required this.labelText,
      this.obscureText = false,
      this.textInputType,
      this.error,
      this.suffixIcon})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final String? error;
  final Widget? suffixIcon;

  
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          label: Text(labelText), errorText: error, suffixIcon: suffixIcon),
      controller: controller,
      style: const TextStyle(color: Colors.black),
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: textInputType,
    );
  }
}
