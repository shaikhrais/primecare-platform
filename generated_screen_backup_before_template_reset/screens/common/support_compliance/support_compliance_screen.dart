import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/support_compliance_header_section.dart';
import 'sections/support_compliance_content_summary_section.dart';
import 'sections/support_compliance_primary_content_section.dart';
import 'sections/support_compliance_action_bar_section.dart';

class SupportComplianceScreen extends StatelessWidget {
  const SupportComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'support_compliance',
      title: 'SupportComplianceScreen',
      child: Column(
        children: const [
          const SupportComplianceHeaderSection(),
          const SupportComplianceContentSummarySection(),
          const SupportCompliancePrimaryContentSection(),
          const SupportComplianceActionBarSection(),
        ],
      ),
    );
  }
}
