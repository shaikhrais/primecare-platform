import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';
import '../theme/design_system.dart';

class PrimeCareCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool muted;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final Clip clipBehavior;

  const PrimeCareCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(PrimeCareSpacing.md),
    this.margin,
    this.onTap,
    this.muted = false,
    this.backgroundColor,
    this.width,
    this.height,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: backgroundColor ?? PrimeCareDesignSystem.surfaceElevated,
      borderRadius: BorderRadius.circular(20), // Premium smooth curve
      border: muted
          ? null
          : Border.all(color: Colors.grey.withValues(alpha: 0.15), width: 1.0),
      boxShadow: muted
          ? []
          : [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.04,
                ), // Soft diffused SaaS shadow
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
    );

    if (onTap != null) {
      return Container(
        margin: margin,
        width: width,
        height: height,
        clipBehavior: clipBehavior,
        decoration: decoration,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: PrimeCareRadii.boardLg,
            child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
          ),
        ),
      );
    }

    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      clipBehavior: clipBehavior,
      decoration: decoration,
      child: child,
    );
  }
}
