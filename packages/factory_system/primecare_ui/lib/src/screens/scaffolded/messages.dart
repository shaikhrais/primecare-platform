import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class Messages extends ConsumerWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'Messages',
      subtitle: 'Auto-scaffolded module',
      kpiCards: SizedBox(),
      child: Center(child: Text('Provisioning...')),
    );
  }
}
