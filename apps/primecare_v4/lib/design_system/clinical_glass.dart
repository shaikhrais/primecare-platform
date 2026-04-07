import 'package:flutter/material.dart';
import 'primecare_theme.dart';

class ClinicalGlassPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BoxBorder? border;
  final double? width;
  final Widget? headerTrailing;
  final String? title;

  const ClinicalGlassPanel({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.border,
    this.width,
    this.headerTrailing,
    this.title,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || headerTrailing != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Text(title!, style: PrimeCareTheme.typography.h3)
                  else
                    const SizedBox(),
                  if (headerTrailing != null) headerTrailing!,
                ],
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class ClinicalGlassButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final String label;
  final bool isFullWidth;
  final bool isActive;
  final bool isPrimary; // Backward compatibility

  const ClinicalGlassButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.isFullWidth = false,
    this.isActive = true,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    // If not active, or not primary, fade the colors slightly.
    // In original code, isActive = true & isPrimary = true meant fully colored button.
    final effectiveActive = isActive && isPrimary;

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
        backgroundColor: effectiveActive
            ? PrimeCareTheme.colors.emeraldTeal
            : PrimeCareTheme.colors.surfaceContainerHighest,
        foregroundColor: effectiveActive
            ? Colors.white
            : PrimeCareTheme.colors.slateGray,
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
