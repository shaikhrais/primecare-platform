import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class Cases extends StatelessWidget {
  const Cases({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'Cases',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
