import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/providers/portal_providers.dart';
import '../theme/theme_tokens.dart';
import '../theme/design_system.dart';

class PrimeCareCard extends ConsumerWidget {
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
    this.padding,
    this.margin,
    this.onTap,
    this.muted = false,
    this.backgroundColor,
    this.width,
    this.height,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;

    final effectivePadding =
        padding ?? EdgeInsets.all(PrimeCareSpacing.md * scale);
    final borderRadius = PrimeCareRadii.scaled(scale);

    final decoration = BoxDecoration(
      color: backgroundColor ?? PrimeCareDesignSystem.surfaceElevated,
      borderRadius: borderRadius,
      border: muted
          ? null
          : Border.all(color: PrimeCareDesignSystem.borderSubtle, width: 1.0),
      boxShadow: muted
          ? []
          : [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.04,
                ), // Institutional depth
                blurRadius: 12 * scale,
                offset: Offset(0, 4 * scale),
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
          borderRadius: borderRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Padding(padding: effectivePadding, child: child),
          ),
        ),
      );
    }

    return Container(
      margin: margin,
      padding: effectivePadding,
      width: width,
      height: height,
      clipBehavior: clipBehavior,
      decoration: decoration,
      child: child,
    );
  }
}
