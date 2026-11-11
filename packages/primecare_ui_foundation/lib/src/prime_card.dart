import 'package:flutter/material.dart';

/// Shared card primitive that preserves Material's themed defaults.
class PrimeCard extends Card {
  const PrimeCard({
    super.key,
    super.color,
    super.shadowColor,
    super.surfaceTintColor,
    super.elevation,
    super.shape,
    super.borderOnForeground = true,
    super.margin,
    super.clipBehavior = Clip.none,
    super.child,
    super.semanticContainer = true,
  });
}
