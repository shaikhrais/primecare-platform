import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_compliance_header_section.dart';
import 'sections/partnership_manager_compliance_content_summary_section.dart';
import 'sections/partnership_manager_compliance_primary_content_section.dart';
import 'sections/partnership_manager_compliance_action_bar_section.dart';

class PartnershipManagerComplianceScreen extends StatelessWidget {
  const PartnershipManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_compliance',
      title: 'PartnershipManagerComplianceScreen',
      child: Column(
        children: const [
          const PartnershipManagerComplianceHeaderSection(),
          const PartnershipManagerComplianceContentSummarySection(),
          const PartnershipManagerCompliancePrimaryContentSection(),
          const PartnershipManagerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
