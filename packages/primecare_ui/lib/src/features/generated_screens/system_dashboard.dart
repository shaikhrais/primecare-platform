import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SystemDashboard extends StatelessWidget {
  const SystemDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'SystemDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
