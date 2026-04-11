import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingdirectorTrainerAssignmentsScreenStitch extends ConsumerWidget {
  const TrainingdirectorTrainerAssignmentsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'corporate.roles.training_director.screens.cor_766.title',
        subtitle: 'corporate.roles.training_director.screens.cor_766.subtitle',
        provider: commonFeatureDataProvider('cor_766'),
      );
}
