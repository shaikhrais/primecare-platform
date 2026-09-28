import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_contracts_header_section.dart';
import 'sections/franchise_sales_manager_contracts_content_summary_section.dart';
import 'sections/franchise_sales_manager_contracts_primary_content_section.dart';
import 'sections/franchise_sales_manager_contracts_action_bar_section.dart';

class FranchiseSalesManagerContractsScreen extends StatelessWidget {
  const FranchiseSalesManagerContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_contracts',
      title: 'Franchise Sales Manager Contracts',
      child: Column(
        children: const [
          const FranchiseSalesManagerContractsHeaderSection(),
          const FranchiseSalesManagerContractsContentSummarySection(),
          const FranchiseSalesManagerContractsPrimaryContentSection(),
          const FranchiseSalesManagerContractsActionBarSection(),
        ],
      ),
    );
  }
}
