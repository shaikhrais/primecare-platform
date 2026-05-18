import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ApiMonitoring extends StatelessWidget {
  const ApiMonitoring({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'ApiMonitoring',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
