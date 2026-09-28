import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_leads_header_section.dart';
import 'sections/territory_sales_manager_leads_content_summary_section.dart';
import 'sections/territory_sales_manager_leads_primary_content_section.dart';
import 'sections/territory_sales_manager_leads_action_bar_section.dart';

class TerritorySalesManagerLeadsScreen extends StatelessWidget {
  const TerritorySalesManagerLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_leads',
      title: 'Territory Sales Manager Leads',
      child: Column(
        children: const [
          const TerritorySalesManagerLeadsHeaderSection(),
          const TerritorySalesManagerLeadsContentSummarySection(),
          const TerritorySalesManagerLeadsPrimaryContentSection(),
          const TerritorySalesManagerLeadsActionBarSection(),
        ],
      ),
    );
  }
}
