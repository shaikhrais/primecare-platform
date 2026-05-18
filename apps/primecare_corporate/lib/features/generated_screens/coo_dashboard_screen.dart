import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CooDashboardScreen extends StatelessWidget {
  const CooDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CooDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
