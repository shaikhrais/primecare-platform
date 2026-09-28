import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_pipeline_header_section.dart';
import 'sections/territory_sales_manager_pipeline_content_summary_section.dart';
import 'sections/territory_sales_manager_pipeline_primary_content_section.dart';
import 'sections/territory_sales_manager_pipeline_action_bar_section.dart';

class TerritorySalesManagerPipelineScreen extends StatelessWidget {
  const TerritorySalesManagerPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_pipeline',
      title: 'Territory Sales Manager Pipeline',
      child: Column(
        children: const [
          const TerritorySalesManagerPipelineHeaderSection(),
          const TerritorySalesManagerPipelineContentSummarySection(),
          const TerritorySalesManagerPipelinePrimaryContentSection(),
          const TerritorySalesManagerPipelineActionBarSection(),
        ],
      ),
    );
  }
}
