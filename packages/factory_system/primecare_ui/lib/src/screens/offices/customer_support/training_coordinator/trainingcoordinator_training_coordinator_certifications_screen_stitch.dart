import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingcoordinatorTrainingCoordinatorCertificationsScreenStitch extends ConsumerWidget {
  const TrainingcoordinatorTrainingCoordinatorCertificationsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'customer_support.roles.training_coordinator.screens.cor_770.title',
        subtitle: 'customer_support.roles.training_coordinator.screens.cor_770.subtitle',
        provider: commonFeatureDataProvider('cor_770'),
      );
}
