import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onTap,
    this.controller,
    required this.icon,
    required this.label,
    required this.hint,
    this.obscureText,
    this.keyboardType,
    this.maxLines,
    this.readOnly,
  });

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final IconData icon;
  final String label;
  final String hint;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        hintText: hint,
        // hintStyle: const TextStyle(
        //   color: Colors.black,
        // ),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
