import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';
import '../theme/theme_extension.dart';

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
    final t = context.pTheme;
    
    final decoration = BoxDecoration(
      color: backgroundColor ?? t.surfaceElevated,
      borderRadius: PrimeCareRadii.boardLg,
      border: muted ? null : Border.all(color: t.borderSubtle, width: 1.0),
      boxShadow: muted ? [] : const [PrimeCareShadows.soft],
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
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            ),
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
