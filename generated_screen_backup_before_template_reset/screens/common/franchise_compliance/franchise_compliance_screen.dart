import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_compliance_header_section.dart';
import 'sections/franchise_compliance_content_summary_section.dart';
import 'sections/franchise_compliance_primary_content_section.dart';
import 'sections/franchise_compliance_action_bar_section.dart';

class FranchiseComplianceScreen extends StatelessWidget {
  const FranchiseComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_compliance',
      title: 'FranchiseComplianceScreen',
      child: Column(
        children: const [
          const FranchiseComplianceHeaderSection(),
          const FranchiseComplianceContentSummarySection(),
          const FranchiseCompliancePrimaryContentSection(),
          const FranchiseComplianceActionBarSection(),
        ],
      ),
    );
  }
}
