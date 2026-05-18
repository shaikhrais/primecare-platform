import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GlobalSettings extends StatelessWidget {
  const GlobalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'GlobalSettings',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
