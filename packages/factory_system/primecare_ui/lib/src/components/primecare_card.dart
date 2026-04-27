// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/providers/portal_providers.dart';

import 'package:primecare_ui/src/theme/design_system.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';

class PrimeCareCard extends ConsumerWidget {
  final String? title;
  final String? subtitle;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool muted;
  final bool isFlat;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final Clip clipBehavior;

  const PrimeCareCard({
    super.key,
    this.title,
    this.subtitle,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.muted = false,
    this.isFlat = false,
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
      border: (muted && !isFlat)
          ? null
          : Border.all(
              color: isFlat
                  ? PrimeCareColors.slate400
                  : PrimeCareDesignSystem.borderSubtle,
              width: 1.0,
            ),
      boxShadow: (muted || isFlat)
          ? []
          : [
              BoxShadow(
                color: PrimeCareColors.black.withValues(
                  alpha: 0.04,
                ), // Institutional depth
                blurRadius: 12 * scale,
                offset: Offset(0, 4 * scale),
              ),
            ],
    );

    final ds = context.theme;

    Widget content = child;
    if (title != null || subtitle != null) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || subtitle != null)
            Padding(
              padding: EdgeInsets.only(bottom: PrimeCareSpacing.md * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: ds.typography.h4.copyWith(
                        color: ds.colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4 * scale),
                    Text(
                      subtitle!,
                      style: ds.typography.bodySmall.copyWith(
                        color: ds.colors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          child,
        ],
      );
    }

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
            child: Padding(padding: effectivePadding, child: content),
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
      child: content,
    );
  }
}
