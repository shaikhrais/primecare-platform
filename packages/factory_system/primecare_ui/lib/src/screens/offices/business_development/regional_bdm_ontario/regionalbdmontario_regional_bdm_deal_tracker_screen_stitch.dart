import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegionalbdmontarioRegionalBdmDealTrackerScreenStitch extends ConsumerWidget {
  const RegionalbdmontarioRegionalBdmDealTrackerScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles.regional_bdm_ontario.screens.bdv_611.title',
        subtitle: 'business_development.roles.regional_bdm_ontario.screens.bdv_611.subtitle',
        provider: commonFeatureDataProvider('bdv_611'),
      );
}
