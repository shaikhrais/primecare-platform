import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingcoordinatorTrainingCoordinatorDashboardScreenStitch extends ConsumerWidget {
  const TrainingcoordinatorTrainingCoordinatorDashboardScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'customer_support.roles.training_coordinator.screens.sup_431.title',
        subtitle: 'customer_support.roles.training_coordinator.screens.sup_431.subtitle',
        provider: commonFeatureDataProvider('sup_431'),
      );
}
