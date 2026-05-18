import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RnDashboardScreen extends StatelessWidget {
  const RnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'RnDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
