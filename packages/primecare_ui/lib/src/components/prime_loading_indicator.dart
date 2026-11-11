import 'package:flutter/material.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeCircularProgressIndicator;
import '../theme/prime_theme.dart';

/// Shared indeterminate progress indicator that follows the inherited theme.
class PrimeLoadingIndicator extends StatelessWidget {
  const PrimeLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => PrimeCircularProgressIndicator(
    color: context.theme.colors.primary,
  );
}
