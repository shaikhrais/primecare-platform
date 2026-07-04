import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_compliance_header_section.dart';
import 'sections/rmt_compliance_content_summary_section.dart';
import 'sections/rmt_compliance_primary_content_section.dart';
import 'sections/rmt_compliance_action_bar_section.dart';

class RmtComplianceScreen extends StatelessWidget {
  const RmtComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_compliance',
      title: 'RmtComplianceScreen',
      child: Column(
        children: const [
          const RmtComplianceHeaderSection(),
          const RmtComplianceContentSummarySection(),
          const RmtCompliancePrimaryContentSection(),
          const RmtComplianceActionBarSection(),
        ],
      ),
    );
  }
}
