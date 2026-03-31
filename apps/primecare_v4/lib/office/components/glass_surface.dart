import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class GlassSurface extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool hasGhostBorder;

  const GlassSurface({
    Key? key,
    required this.child,
    this.borderRadius = 24.0,
    this.padding = EdgeInsets.zero,
    this.hasGhostBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppTheme.ambientShadow, // Ambient separation
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0), // The Glassmorphism Rule
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
               color: AppTheme.surface.withOpacity(0.85),
               borderRadius: BorderRadius.circular(borderRadius),
               border: hasGhostBorder ? Border.all(
                  color: AppTheme.outlineVariant.withOpacity(0.15), // Ghost Border fallback
                  width: 1,
               ) : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
