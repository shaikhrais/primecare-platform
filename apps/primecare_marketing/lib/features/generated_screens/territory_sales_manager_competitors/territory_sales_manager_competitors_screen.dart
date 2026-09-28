import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_competitors_header_section.dart';
import 'sections/territory_sales_manager_competitors_content_summary_section.dart';
import 'sections/territory_sales_manager_competitors_primary_content_section.dart';
import 'sections/territory_sales_manager_competitors_action_bar_section.dart';

class TerritorySalesManagerCompetitorsScreen extends StatelessWidget {
  const TerritorySalesManagerCompetitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_competitors',
      title: 'Territory Sales Manager Competitors',
      child: Column(
        children: const [
          const TerritorySalesManagerCompetitorsHeaderSection(),
          const TerritorySalesManagerCompetitorsContentSummarySection(),
          const TerritorySalesManagerCompetitorsPrimaryContentSection(),
          const TerritorySalesManagerCompetitorsActionBarSection(),
        ],
      ),
    );
  }
}
