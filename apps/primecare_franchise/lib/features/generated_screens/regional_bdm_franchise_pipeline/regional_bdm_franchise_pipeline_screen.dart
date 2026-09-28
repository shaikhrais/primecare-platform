import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_franchise_pipeline_header_section.dart';
import 'sections/regional_bdm_franchise_pipeline_content_summary_section.dart';
import 'sections/regional_bdm_franchise_pipeline_primary_content_section.dart';
import 'sections/regional_bdm_franchise_pipeline_action_bar_section.dart';

class RegionalBdmFranchisePipelineScreen extends StatelessWidget {
  const RegionalBdmFranchisePipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_franchise_pipeline',
      title: 'Regional Bdm Franchise Pipeline',
      child: Column(
        children: const [
          const RegionalBdmFranchisePipelineHeaderSection(),
          const RegionalBdmFranchisePipelineContentSummarySection(),
          const RegionalBdmFranchisePipelinePrimaryContentSection(),
          const RegionalBdmFranchisePipelineActionBarSection(),
        ],
      ),
    );
  }
}
