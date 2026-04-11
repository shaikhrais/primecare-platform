import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingdirectorTrainingReportsScreenStitch extends ConsumerWidget {
  const TrainingdirectorTrainingReportsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'corporate.roles.training_director.screens.cor_767.title',
        subtitle: 'corporate.roles.training_director.screens.cor_767.subtitle',
        provider: commonFeatureDataProvider('cor_767'),
      );
}
