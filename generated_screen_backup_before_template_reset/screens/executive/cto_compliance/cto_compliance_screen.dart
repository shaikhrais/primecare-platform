import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_compliance_header_section.dart';
import 'sections/cto_compliance_content_summary_section.dart';
import 'sections/cto_compliance_primary_content_section.dart';
import 'sections/cto_compliance_action_bar_section.dart';

class CtoComplianceScreen extends StatelessWidget {
  const CtoComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_compliance',
      title: 'CtoComplianceScreen',
      child: Column(
        children: const [
          const CtoComplianceHeaderSection(),
          const CtoComplianceContentSummarySection(),
          const CtoCompliancePrimaryContentSection(),
          const CtoComplianceActionBarSection(),
        ],
      ),
    );
  }
}
