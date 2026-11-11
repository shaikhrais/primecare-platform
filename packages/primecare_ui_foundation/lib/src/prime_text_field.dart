import 'package:flutter/material.dart';

/// Shared Material text input delegate for the reviewed constructor surface.
class PrimeTextField extends StatelessWidget {
  final Key? fieldKey;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final bool autofocus;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const PrimeTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.enabled,
    this.autofocus = false,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
  }) : fieldKey = key;

  @override
  Widget build(BuildContext context) => TextField(
        key: fieldKey,
        controller: controller,
        focusNode: focusNode,
        decoration: decoration,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        enabled: enabled,
        autofocus: autofocus,
        obscureText: obscureText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      );
}
