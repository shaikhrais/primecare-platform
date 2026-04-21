// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/theme/01_I_primecare_theme.dart';

typedef ClinicalGlass = ClinicalGlassPanel;

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
    final theme = PrimeCareTheme.of(context);
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: PrimeCareColors.white,
        borderRadius: BorderRadius.circular(24),
        border:
            border ??
            Border.all(
              color: theme.colors.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
            ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF191C1E).withValues(alpha: 0.04),
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
                    Text(title!, style: theme.typography.h3),
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
  final ClinicalButtonVariant variant;

  const ClinicalGlassButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.isFullWidth = false,
    this.isActive = true,
    this.isPrimary = true,
    this.variant = ClinicalButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    
    // Handle variants
    Color backgroundColor;
    Color foregroundColor;
    
    switch (variant) {
      case ClinicalButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colors.primary;
        break;
      case ClinicalButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colors.primary;
        break;
      case ClinicalButtonVariant.primary:
        final effectiveActive = isActive && isPrimary;
        backgroundColor = effectiveActive
            ? theme.colors.emeraldTeal
            : theme.colors.surfaceContainerHighest;
        foregroundColor = effectiveActive
            ? PrimeCareColors.white
            : theme.colors.slateGray;
        break;
    }

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
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: variant == ClinicalButtonVariant.outline 
            ? BorderSide(color: theme.outlineVariant)
            : BorderSide.none,
        ),
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

enum ClinicalButtonVariant {
  primary,
  ghost,
  outline,
}

class ClinicalSearchTextField extends StatelessWidget {
  final String hintText;
  final double width;

  const ClinicalSearchTextField({
    super.key, 
    required this.hintText,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            color: theme.outlineVariant.withValues(alpha: 0.5),
          ),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: theme.colors.slateGray),
        ),
      ),
    );
  }
}
