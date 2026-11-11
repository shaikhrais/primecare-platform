import 'package:flutter/material.dart';
import '../theme/prime_theme.dart';

/// Shared indeterminate progress indicator that follows the inherited theme.
class PrimeLoadingIndicator extends StatelessWidget {
  const PrimeLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
    color: context.theme.colors.primary,
  );
}
