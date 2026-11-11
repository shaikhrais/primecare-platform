import 'package:flutter/material.dart';

/// Shared snack-bar primitive that preserves Material's themed behavior.
class PrimeSnackBar extends SnackBar {
  const PrimeSnackBar({
    super.key,
    required super.content,
    super.backgroundColor,
    super.elevation,
    super.margin,
    super.padding,
    super.width,
    super.shape,
    super.hitTestBehavior,
    super.behavior,
    super.action,
    super.actionOverflowThreshold,
    super.showCloseIcon,
    super.closeIconColor,
    super.duration = const Duration(milliseconds: 4000),
    super.persist,
    super.animation,
    super.onVisible,
    super.dismissDirection,
    super.clipBehavior = Clip.hardEdge,
  });
}
