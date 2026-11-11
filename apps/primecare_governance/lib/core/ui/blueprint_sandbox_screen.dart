// Governance - Category: view | Purpose: Coordinator layout for Blueprint Sandbox
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:primecare_ui/primecare_ui.dart' show PrimeScaffold;
import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlueprintSandboxScreen extends ConsumerWidget {
  const BlueprintSandboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PrimeScaffold(
      body: Center(
        child: PrimeText('Blueprint Sandbox Coordinator'),
      ),
    );
  }
}
