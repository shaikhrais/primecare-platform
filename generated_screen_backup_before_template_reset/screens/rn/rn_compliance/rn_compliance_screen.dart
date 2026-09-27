import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_compliance_header_section.dart';
import 'sections/rn_compliance_content_summary_section.dart';
import 'sections/rn_compliance_primary_content_section.dart';
import 'sections/rn_compliance_action_bar_section.dart';

class RnComplianceScreen extends StatelessWidget {
  const RnComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_compliance',
      title: 'RnComplianceScreen',
      child: Column(
        children: const [
          const RnComplianceHeaderSection(),
          const RnComplianceContentSummarySection(),
          const RnCompliancePrimaryContentSection(),
          const RnComplianceActionBarSection(),
        ],
      ),
    );
  }
}
