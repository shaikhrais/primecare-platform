import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class QaDashboardScreen extends StatelessWidget {
  const QaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'QaDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
