import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CtoDashboardScreen extends StatelessWidget {
  const CtoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CtoDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
