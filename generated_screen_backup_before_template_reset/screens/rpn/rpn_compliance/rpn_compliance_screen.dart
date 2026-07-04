import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_compliance_header_section.dart';
import 'sections/rpn_compliance_content_summary_section.dart';
import 'sections/rpn_compliance_primary_content_section.dart';
import 'sections/rpn_compliance_action_bar_section.dart';

class RpnComplianceScreen extends StatelessWidget {
  const RpnComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_compliance',
      title: 'RpnComplianceScreen',
      child: Column(
        children: const [
          const RpnComplianceHeaderSection(),
          const RpnComplianceContentSummarySection(),
          const RpnCompliancePrimaryContentSection(),
          const RpnComplianceActionBarSection(),
        ],
      ),
    );
  }
}
