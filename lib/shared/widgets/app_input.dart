import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String label;
  final String? hint;
  final bool obscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const AppInput({
    required this.label,
    this.hint,
    this.obscure = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onEditingComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
