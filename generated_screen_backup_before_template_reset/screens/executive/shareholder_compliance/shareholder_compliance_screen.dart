import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/shareholder_compliance_header_section.dart';
import 'sections/shareholder_compliance_content_summary_section.dart';
import 'sections/shareholder_compliance_primary_content_section.dart';
import 'sections/shareholder_compliance_action_bar_section.dart';

class ShareholderComplianceScreen extends StatelessWidget {
  const ShareholderComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'shareholder_compliance',
      title: 'ShareholderComplianceScreen',
      child: Column(
        children: const [
          const ShareholderComplianceHeaderSection(),
          const ShareholderComplianceContentSummarySection(),
          const ShareholderCompliancePrimaryContentSection(),
          const ShareholderComplianceActionBarSection(),
        ],
      ),
    );
  }
}
