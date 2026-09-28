import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_prospects_header_section.dart';
import 'sections/franchise_sales_manager_prospects_content_summary_section.dart';
import 'sections/franchise_sales_manager_prospects_primary_content_section.dart';
import 'sections/franchise_sales_manager_prospects_action_bar_section.dart';

class FranchiseSalesManagerProspectsScreen extends StatelessWidget {
  const FranchiseSalesManagerProspectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_prospects',
      title: 'Franchise Sales Manager Prospects',
      child: Column(
        children: const [
          const FranchiseSalesManagerProspectsHeaderSection(),
          const FranchiseSalesManagerProspectsContentSummarySection(),
          const FranchiseSalesManagerProspectsPrimaryContentSection(),
          const FranchiseSalesManagerProspectsActionBarSection(),
        ],
      ),
    );
  }
}
