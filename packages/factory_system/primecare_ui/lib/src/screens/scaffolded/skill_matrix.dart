import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SkillMatrix extends ConsumerWidget {
  const SkillMatrix({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'SkillMatrix',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
