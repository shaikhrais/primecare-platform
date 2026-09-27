import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_territory_growth_header_section.dart';
import 'sections/regional_bdm_territory_growth_content_summary_section.dart';
import 'sections/regional_bdm_territory_growth_primary_content_section.dart';
import 'sections/regional_bdm_territory_growth_action_bar_section.dart';

class RegionalBdmTerritoryGrowthScreen extends StatelessWidget {
  const RegionalBdmTerritoryGrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_territory_growth',
      title: 'Regional Bdm Territory Growth',
      child: Column(
        children: const [
          const RegionalBdmTerritoryGrowthHeaderSection(),
          const RegionalBdmTerritoryGrowthContentSummarySection(),
          const RegionalBdmTerritoryGrowthPrimaryContentSection(),
          const RegionalBdmTerritoryGrowthActionBarSection(),
        ],
      ),
    );
  }
}
