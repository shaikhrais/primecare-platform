import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class BusinessOverview extends StatelessWidget {
  const BusinessOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'BusinessOverview',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
