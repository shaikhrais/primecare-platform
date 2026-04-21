import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class HistoryLogsScreen extends ConsumerWidget {
  const HistoryLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'History & Logs',
      subtitle: 'Audit logs and past interactions.',
      bodySections: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'History & Logs Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
