import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class IntakecoordinatorSchedulingScreenStitch extends ConsumerWidget {
  const IntakecoordinatorSchedulingScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'customer_support.roles.intake_coordinator.screens.sup_415.title',
        subtitle: 'customer_support.roles.intake_coordinator.screens.sup_415.subtitle',
        provider: commonFeatureDataProvider('sup_415'),
      );
}
