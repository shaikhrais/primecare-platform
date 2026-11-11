import 'package:flutter/material.dart';

/// Shared icon action retaining SDK theme, focus, semantics and caller geometry.
class PrimeIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final FocusNode? focusNode;
  final bool autofocus;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;

  const PrimeIconButton({super.key, required this.icon, required this.onPressed,
    this.tooltip, this.focusNode, this.autofocus = false,
    this.visualDensity, this.padding, this.constraints});

  @override
  Widget build(BuildContext context) => IconButton(icon: icon, onPressed: onPressed,
    tooltip: tooltip, focusNode: focusNode, autofocus: autofocus,
    visualDensity: visualDensity, padding: padding, constraints: constraints);
}
