import 'package:flutter/material.dart';
import 'primecare_theme.dart';

class ClinicalGlassPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BoxBorder? border;
  final double? width;

  const ClinicalGlassPanel({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.border,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border:
            border ??
            Border.all(
              color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(
                0.5,
              ),
            ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF191C1E).withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ClinicalGlassButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final String label;
  final bool isFullWidth;
  final bool isActive;

  const ClinicalGlassButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.isFullWidth = false,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Text(
      label,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );

    if (icon != null) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          buttonContent,
        ],
      );
    }

    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.surfaceContainerHighest,
        foregroundColor: isActive ? Colors.white : PrimeCareTheme.colors.slateGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: buttonContent,
    );

    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

class ClinicalSearchTextField extends StatelessWidget {
  final String hintText;

  const ClinicalSearchTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            color: PrimeCareTheme.colors.slateGray.withOpacity(0.5),
          ),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: PrimeCareTheme.colors.slateGray),
        ),
      ),
    );
  }
}
