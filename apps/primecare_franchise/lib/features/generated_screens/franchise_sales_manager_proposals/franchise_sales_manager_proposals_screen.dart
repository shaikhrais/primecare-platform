import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_proposals_header_section.dart';
import 'sections/franchise_sales_manager_proposals_content_summary_section.dart';
import 'sections/franchise_sales_manager_proposals_primary_content_section.dart';
import 'sections/franchise_sales_manager_proposals_action_bar_section.dart';

class FranchiseSalesManagerProposalsScreen extends StatelessWidget {
  const FranchiseSalesManagerProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_proposals',
      title: 'Franchise Sales Manager Proposals',
      child: Column(
        children: const [
          const FranchiseSalesManagerProposalsHeaderSection(),
          const FranchiseSalesManagerProposalsContentSummarySection(),
          const FranchiseSalesManagerProposalsPrimaryContentSection(),
          const FranchiseSalesManagerProposalsActionBarSection(),
        ],
      ),
    );
  }
}
