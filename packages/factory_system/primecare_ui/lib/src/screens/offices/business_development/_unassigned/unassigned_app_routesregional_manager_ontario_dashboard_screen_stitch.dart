import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class UnassignedAppRoutesregionalManagerOntarioDashboardScreenStitch extends ConsumerWidget {
  const UnassignedAppRoutesregionalManagerOntarioDashboardScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles._unassigned.screens.bdv_601.title',
        subtitle: 'business_development.roles._unassigned.screens.bdv_601.subtitle',
        provider: commonFeatureDataProvider('bdv_601'),
      );
}
