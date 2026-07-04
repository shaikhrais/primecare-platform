import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_leads_header_section.dart';
import 'sections/franchise_sales_manager_leads_content_summary_section.dart';
import 'sections/franchise_sales_manager_leads_primary_content_section.dart';
import 'sections/franchise_sales_manager_leads_action_bar_section.dart';

class FranchiseSalesManagerLeadsScreen extends StatelessWidget {
  const FranchiseSalesManagerLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_leads',
      title: 'Franchise Sales Manager Leads',
      child: Column(
        children: const [
          const FranchiseSalesManagerLeadsHeaderSection(),
          const FranchiseSalesManagerLeadsContentSummarySection(),
          const FranchiseSalesManagerLeadsPrimaryContentSection(),
          const FranchiseSalesManagerLeadsActionBarSection(),
        ],
      ),
    );
  }
}
