import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsBoard extends StatelessWidget {
  const OperationsBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'OperationsBoard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
