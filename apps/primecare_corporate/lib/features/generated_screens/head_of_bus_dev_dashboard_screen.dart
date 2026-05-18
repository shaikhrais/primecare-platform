import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadOfBusDevDashboardScreen extends StatelessWidget {
  const HeadOfBusDevDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'HeadOfBusDevDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
