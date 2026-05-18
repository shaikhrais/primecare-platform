import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CarePlan extends StatelessWidget {
  const CarePlan({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CarePlan',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
