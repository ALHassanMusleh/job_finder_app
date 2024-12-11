import 'package:flutter/material.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.suffixPressed,
    required this.controller,
    required this.type,
    this.onSubmitted,
    this.onChanged,
    required this.validate,
    this.initialValue,
    this.isSuffix = false,
  });
  final TextEditingController? controller;
  final TextInputType type;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?) validate;
  final String label;
  final bool isPassword;
  final void Function()? suffixPressed;
  final String? initialValue;
  final bool isSuffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validate,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: isSuffix
            ? IconButton(
                onPressed: suffixPressed,
                icon: isPassword
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(Icons.visibility_off_outlined),
              )
            : null,
        labelStyle: AppStyle.labelStyle,
        labelText: label,
        fillColor: const Color(0xFFF9F9FA),
        filled: true,
      ),
    );
  }
}
