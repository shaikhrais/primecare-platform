import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritoryexpansionmanagerTerritoryExpansionManagerOpenTerritoriesScreenStitch extends ConsumerWidget {
  const TerritoryexpansionmanagerTerritoryExpansionManagerOpenTerritoriesScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles.territory_expansion_manager.screens.bdv_633.title',
        subtitle: 'business_development.roles.territory_expansion_manager.screens.bdv_633.subtitle',
        provider: commonFeatureDataProvider('bdv_633'),
      );
}
