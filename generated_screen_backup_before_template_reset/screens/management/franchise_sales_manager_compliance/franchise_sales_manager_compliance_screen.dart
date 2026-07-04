import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_compliance_header_section.dart';
import 'sections/franchise_sales_manager_compliance_content_summary_section.dart';
import 'sections/franchise_sales_manager_compliance_primary_content_section.dart';
import 'sections/franchise_sales_manager_compliance_action_bar_section.dart';

class FranchiseSalesManagerComplianceScreen extends StatelessWidget {
  const FranchiseSalesManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_compliance',
      title: 'FranchiseSalesManagerComplianceScreen',
      child: Column(
        children: const [
          const FranchiseSalesManagerComplianceHeaderSection(),
          const FranchiseSalesManagerComplianceContentSummarySection(),
          const FranchiseSalesManagerCompliancePrimaryContentSection(),
          const FranchiseSalesManagerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
