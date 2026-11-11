import 'package:flutter/material.dart';

/// Shared plain icon action. Material supplies the active theme, focus,
/// disabled state, keyboard activation and minimum interactive target.
class PrimeIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  const PrimeIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) => IconButton(icon: icon, onPressed: onPressed);
}
