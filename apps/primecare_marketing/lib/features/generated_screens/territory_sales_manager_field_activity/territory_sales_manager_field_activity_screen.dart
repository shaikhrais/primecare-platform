import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_field_activity_header_section.dart';
import 'sections/territory_sales_manager_field_activity_content_summary_section.dart';
import 'sections/territory_sales_manager_field_activity_primary_content_section.dart';
import 'sections/territory_sales_manager_field_activity_action_bar_section.dart';

class TerritorySalesManagerFieldActivityScreen extends StatelessWidget {
  const TerritorySalesManagerFieldActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_field_activity',
      title: 'Territory Sales Manager Field Activity',
      child: Column(
        children: const [
          const TerritorySalesManagerFieldActivityHeaderSection(),
          const TerritorySalesManagerFieldActivityContentSummarySection(),
          const TerritorySalesManagerFieldActivityPrimaryContentSection(),
          const TerritorySalesManagerFieldActivityActionBarSection(),
        ],
      ),
    );
  }
}
