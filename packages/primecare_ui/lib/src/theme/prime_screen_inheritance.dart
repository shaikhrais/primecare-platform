import 'package:flutter/material.dart';
import 'package:flutter_core/models/screen_features.dart';
import 'prime_theme.dart';

/// A scoped view of the active PrimeCare and Material themes, screen policy,
/// locale and direction. Re-read from the build context to follow updates.
class PrimeScreenInheritanceManager extends ScreenInheritanceManager {
  const PrimeScreenInheritanceManager({
    required super.features,
    required super.theme,
    required super.locale,
    required super.direction,
    required this.primeTheme,
  });

  final PrimeThemeData primeTheme;

  factory PrimeScreenInheritanceManager.of(BuildContext context, {ScreenFeatureConfig? override}) {
    final inherited = ScreenInheritanceManager.of(context, override: override);
    return PrimeScreenInheritanceManager(
      features: inherited.features,
      theme: inherited.theme,
      locale: inherited.locale,
      direction: inherited.direction,
      primeTheme: PrimeTheme.of(context),
    );
  }
}

extension PrimeScreenInheritanceContext on BuildContext {
  PrimeScreenInheritanceManager get primeScreenInheritance => PrimeScreenInheritanceManager.of(this);
}
