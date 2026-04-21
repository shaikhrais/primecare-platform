// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class Cases extends ConsumerWidget {
  const Cases({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'Cases',
      subtitle: 'Auto-scaffolded module',
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
