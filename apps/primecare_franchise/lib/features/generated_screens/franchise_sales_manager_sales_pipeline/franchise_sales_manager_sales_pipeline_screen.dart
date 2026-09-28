import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_sales_pipeline_header_section.dart';
import 'sections/franchise_sales_manager_sales_pipeline_content_summary_section.dart';
import 'sections/franchise_sales_manager_sales_pipeline_primary_content_section.dart';
import 'sections/franchise_sales_manager_sales_pipeline_action_bar_section.dart';

class FranchiseSalesManagerSalesPipelineScreen extends StatelessWidget {
  const FranchiseSalesManagerSalesPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_sales_pipeline',
      title: 'Franchise Sales Manager Sales Pipeline',
      child: Column(
        children: const [
          const FranchiseSalesManagerSalesPipelineHeaderSection(),
          const FranchiseSalesManagerSalesPipelineContentSummarySection(),
          const FranchiseSalesManagerSalesPipelinePrimaryContentSection(),
          const FranchiseSalesManagerSalesPipelineActionBarSection(),
        ],
      ),
    );
  }
}
