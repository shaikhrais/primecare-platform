import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_franchise_financials_header_section.dart';
import 'sections/cfo_franchise_financials_content_summary_section.dart';
import 'sections/cfo_franchise_financials_primary_content_section.dart';
import 'sections/cfo_franchise_financials_action_bar_section.dart';

class CfoFranchiseFinancialsScreen extends StatelessWidget {
  const CfoFranchiseFinancialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_franchise_financials',
      title: 'Cfo Franchise Financials',
      child: Column(
        children: const [
          const CfoFranchiseFinancialsHeaderSection(),
          const CfoFranchiseFinancialsContentSummarySection(),
          const CfoFranchiseFinancialsPrimaryContentSection(),
          const CfoFranchiseFinancialsActionBarSection(),
        ],
      ),
    );
  }
}
