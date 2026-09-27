import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_site_selection_header_section.dart';
import 'sections/territory_expansion_manager_site_selection_content_summary_section.dart';
import 'sections/territory_expansion_manager_site_selection_primary_content_section.dart';
import 'sections/territory_expansion_manager_site_selection_action_bar_section.dart';

class TerritoryExpansionManagerSiteSelectionScreen extends StatelessWidget {
  const TerritoryExpansionManagerSiteSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_site_selection',
      title: 'Territory Expansion Manager Site Selection',
      child: Column(
        children: const [
          const TerritoryExpansionManagerSiteSelectionHeaderSection(),
          const TerritoryExpansionManagerSiteSelectionContentSummarySection(),
          const TerritoryExpansionManagerSiteSelectionPrimaryContentSection(),
          const TerritoryExpansionManagerSiteSelectionActionBarSection(),
        ],
      ),
    );
  }
}
