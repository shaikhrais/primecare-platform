// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class FamilyHome extends ConsumerWidget {
  const FamilyHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'FamilyHome',
      subtitle: 'Auto-scaffolded module',
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
