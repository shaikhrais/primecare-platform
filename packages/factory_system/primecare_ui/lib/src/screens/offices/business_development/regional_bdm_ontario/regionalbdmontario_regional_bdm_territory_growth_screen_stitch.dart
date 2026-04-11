import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegionalbdmontarioRegionalBdmTerritoryGrowthScreenStitch extends ConsumerWidget {
  const RegionalbdmontarioRegionalBdmTerritoryGrowthScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles.regional_bdm_ontario.screens.bdv_609.title',
        subtitle: 'business_development.roles.regional_bdm_ontario.screens.bdv_609.subtitle',
        provider: commonFeatureDataProvider('bdv_609'),
      );
}
