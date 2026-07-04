import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_market_research_header_section.dart';
import 'sections/territory_expansion_manager_market_research_filter_bar_section.dart';
import 'sections/territory_expansion_manager_market_research_data_table_section.dart';
import 'sections/territory_expansion_manager_market_research_pagination_section.dart';
import 'sections/territory_expansion_manager_market_research_action_bar_section.dart';

class TerritoryExpansionManagerMarketResearchScreen extends StatelessWidget {
  const TerritoryExpansionManagerMarketResearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_market_research',
      title: 'Territory Expansion Manager Market Research',
      child: Column(
        children: const [
          const TerritoryExpansionManagerMarketResearchHeaderSection(),
          const TerritoryExpansionManagerMarketResearchFilterBarSection(),
          const TerritoryExpansionManagerMarketResearchDataTableSection(),
          const TerritoryExpansionManagerMarketResearchPaginationSection(),
          const TerritoryExpansionManagerMarketResearchActionBarSection(),
        ],
      ),
    );
  }
}
