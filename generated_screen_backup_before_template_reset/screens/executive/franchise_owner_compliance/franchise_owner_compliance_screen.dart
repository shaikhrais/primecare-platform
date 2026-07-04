import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_compliance_header_section.dart';
import 'sections/franchise_owner_compliance_content_summary_section.dart';
import 'sections/franchise_owner_compliance_primary_content_section.dart';
import 'sections/franchise_owner_compliance_action_bar_section.dart';

class FranchiseOwnerComplianceScreen extends StatelessWidget {
  const FranchiseOwnerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_compliance',
      title: 'FranchiseOwnerComplianceScreen',
      child: Column(
        children: const [
          const FranchiseOwnerComplianceHeaderSection(),
          const FranchiseOwnerComplianceContentSummarySection(),
          const FranchiseOwnerCompliancePrimaryContentSection(),
          const FranchiseOwnerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
