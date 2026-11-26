import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import '../components/cy.dart';
import '../components/prime_components.dart';
import '../theme/prime_theme.dart';

/// Presentation for existing configuration screens whose provider contracts and
/// permissions are incomplete. No guessed endpoint, credential form or success
/// fallback is exposed. Activation requires the governed configuration workflow.
abstract class UnavailableConfigurationScreen extends GovernedConsumerWidget {
  static const implementationTags = {
    'logic': 'unimplemented',
    'api': 'unbound',
    'productionReady': false,
  };
  final String screenCode;
  const UnavailableConfigurationScreen({super.key, required this.screenCode});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final language = Localizations.localeOf(context).languageCode;
    return Cy(
      id: 'screen-${screenCode.replaceAll('_', '-')}',
      child: Center(
        child: PrimeCareCard(
          color: Theme.of(context).colorScheme.surface,
          padding: EdgeInsets.all(context.theme.spacing.lg),
          child: Semantics(
            liveRegion: true,
            child: Text(CommunicationWorkspaceCatalog.text(language, 'unavailable')),
          ),
        ),
      ),
    );
  }
}
