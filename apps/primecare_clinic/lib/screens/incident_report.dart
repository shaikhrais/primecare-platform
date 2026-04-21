import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class IncidentReportScreen extends ConsumerWidget {
  const IncidentReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Incident Report',
      subtitle: 'File reports for any incidents.',
      bodySections: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Incident Report Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
