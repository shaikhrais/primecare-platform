import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_demographics_header_section.dart';
import 'sections/territory_expansion_manager_demographics_content_summary_section.dart';
import 'sections/territory_expansion_manager_demographics_primary_content_section.dart';
import 'sections/territory_expansion_manager_demographics_action_bar_section.dart';

class TerritoryExpansionManagerDemographicsScreen extends StatelessWidget {
  const TerritoryExpansionManagerDemographicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_demographics',
      title: 'Territory Expansion Manager Demographics',
      child: Column(
        children: const [
          const TerritoryExpansionManagerDemographicsHeaderSection(),
          const TerritoryExpansionManagerDemographicsContentSummarySection(),
          const TerritoryExpansionManagerDemographicsPrimaryContentSection(),
          const TerritoryExpansionManagerDemographicsActionBarSection(),
        ],
      ),
    );
  }
}
