import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorysalesmanagerTerritorySalesManagerLeadsScreenStitch extends ConsumerWidget {
  const TerritorysalesmanagerTerritorySalesManagerLeadsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.territory_sales_manager.screens.mkt_925.title',
        subtitle: 'marketing.roles.territory_sales_manager.screens.mkt_925.subtitle',
        provider: commonFeatureDataProvider('mkt_925'),
      );
}
