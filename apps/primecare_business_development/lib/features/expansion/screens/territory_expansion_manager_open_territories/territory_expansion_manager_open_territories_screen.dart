import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_open_territories_header_section.dart';
import 'sections/territory_expansion_manager_open_territories_content_summary_section.dart';
import 'sections/territory_expansion_manager_open_territories_primary_content_section.dart';
import 'sections/territory_expansion_manager_open_territories_action_bar_section.dart';

class TerritoryExpansionManagerOpenTerritoriesScreen extends StatelessWidget {
  const TerritoryExpansionManagerOpenTerritoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_open_territories',
      title: 'Territory Expansion Manager Open Territories',
      child: Column(
        children: const [
          const TerritoryExpansionManagerOpenTerritoriesHeaderSection(),
          const TerritoryExpansionManagerOpenTerritoriesContentSummarySection(),
          const TerritoryExpansionManagerOpenTerritoriesPrimaryContentSection(),
          const TerritoryExpansionManagerOpenTerritoriesActionBarSection(),
        ],
      ),
    );
  }
}
