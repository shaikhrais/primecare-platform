import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingCoordinatorProgressScreen extends StatelessWidget {
  const TrainingCoordinatorProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'TrainingCoordinatorProgressScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
