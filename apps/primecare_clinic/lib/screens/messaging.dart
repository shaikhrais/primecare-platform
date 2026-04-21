import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class MessagingScreen extends ConsumerWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Messaging',
      subtitle: 'Secure communications.',
      bodySections: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Messaging Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
