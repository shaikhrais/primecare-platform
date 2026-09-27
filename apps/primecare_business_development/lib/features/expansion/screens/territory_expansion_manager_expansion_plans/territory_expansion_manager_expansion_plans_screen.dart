import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_expansion_plans_header_section.dart';
import 'sections/territory_expansion_manager_expansion_plans_content_summary_section.dart';
import 'sections/territory_expansion_manager_expansion_plans_primary_content_section.dart';
import 'sections/territory_expansion_manager_expansion_plans_action_bar_section.dart';

class TerritoryExpansionManagerExpansionPlansScreen extends StatelessWidget {
  const TerritoryExpansionManagerExpansionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_expansion_plans',
      title: 'Territory Expansion Manager Expansion Plans',
      child: Column(
        children: const [
          const TerritoryExpansionManagerExpansionPlansHeaderSection(),
          const TerritoryExpansionManagerExpansionPlansContentSummarySection(),
          const TerritoryExpansionManagerExpansionPlansPrimaryContentSection(),
          const TerritoryExpansionManagerExpansionPlansActionBarSection(),
        ],
      ),
    );
  }
}
