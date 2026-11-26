import 'package:primecare_theme/theme/prime_semantic_palette.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeScaffold;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeElevatedButton;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeIcon;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governed_hierarchy/src/domain/platform_hierarchy.dart';

abstract class AuthErrorViewBase extends GovernedScreen {
  final String? returnUrl;

  const AuthErrorViewBase({super.key, this.returnUrl});
  void retrySignIn(BuildContext context);

  @override
  String get featureId => 'auth.error';

  @override
  String get requiredRole => 'Public';

  @override
  List<String> get translationKeys => const [];

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return PrimeScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimeIcon(
                Icons.error_outline_rounded,
                size: 64,
                color: PrimeSemanticPalette.of(context, PrimeSemanticTone.error).onBase,
              ),
              const SizedBox(height: 24),
              PrimeText(
                'Authentication could not be completed.',
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              PrimeText(
                'Please restart sign-in.',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PrimeElevatedButton(
                onPressed: () => retrySignIn(context),
                child: const PrimeText('Retry Sign-In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
