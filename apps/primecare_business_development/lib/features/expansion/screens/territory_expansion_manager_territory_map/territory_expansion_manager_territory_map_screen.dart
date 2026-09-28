import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_territory_map_header_section.dart';
import 'sections/territory_expansion_manager_territory_map_content_summary_section.dart';
import 'sections/territory_expansion_manager_territory_map_primary_content_section.dart';
import 'sections/territory_expansion_manager_territory_map_action_bar_section.dart';

class TerritoryExpansionManagerTerritoryMapScreen extends StatelessWidget {
  const TerritoryExpansionManagerTerritoryMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_territory_map',
      title: 'Territory Expansion Manager Territory Map',
      child: Column(
        children: const [
          const TerritoryExpansionManagerTerritoryMapHeaderSection(),
          const TerritoryExpansionManagerTerritoryMapContentSummarySection(),
          const TerritoryExpansionManagerTerritoryMapPrimaryContentSection(),
          const TerritoryExpansionManagerTerritoryMapActionBarSection(),
        ],
      ),
    );
  }
}
