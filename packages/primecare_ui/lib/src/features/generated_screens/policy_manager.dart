import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PolicyManager extends StatelessWidget {
  const PolicyManager({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'PolicyManager',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
