import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegionalbdmontarioRegionalBdmReportsScreenStitch extends ConsumerWidget {
  const RegionalbdmontarioRegionalBdmReportsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles.regional_bdm_ontario.screens.bdv_615.title',
        subtitle: 'business_development.roles.regional_bdm_ontario.screens.bdv_615.subtitle',
        provider: commonFeatureDataProvider('bdv_615'),
      );
}
