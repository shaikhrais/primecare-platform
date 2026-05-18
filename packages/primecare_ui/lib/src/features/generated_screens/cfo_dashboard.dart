import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CfoDashboard extends StatelessWidget {
  const CfoDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CfoDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
