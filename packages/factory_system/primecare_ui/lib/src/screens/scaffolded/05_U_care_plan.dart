// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class CarePlan extends ConsumerWidget {
  const CarePlan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'CarePlan',
      subtitle: 'Auto-scaffolded module',
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
