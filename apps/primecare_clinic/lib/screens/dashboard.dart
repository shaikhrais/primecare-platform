import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Dashboard',
      subtitle: 'Clinic overview and key metrics.',
      bodySections: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Dashboard Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
