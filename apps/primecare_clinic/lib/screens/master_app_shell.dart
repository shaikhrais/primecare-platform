// Associated data Provider mapped for ViewModel
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class MasterAppShellScreen extends ConsumerWidget {
  const MasterAppShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Master App Shell',
      subtitle: 'Global navigation context.',
      bodySections: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Master App Shell Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
