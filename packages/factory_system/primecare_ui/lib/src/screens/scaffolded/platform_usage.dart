import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PlatformUsage extends ConsumerWidget {
  const PlatformUsage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'PlatformUsage',
      subtitle: 'Auto-scaffolded module',
      kpiCards: SizedBox(),
      child: Center(child: Text('Provisioning...')),
    );
  }
}
