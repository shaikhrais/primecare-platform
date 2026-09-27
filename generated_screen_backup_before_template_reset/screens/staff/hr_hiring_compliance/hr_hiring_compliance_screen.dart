import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_compliance_header_section.dart';
import 'sections/hr_hiring_compliance_content_summary_section.dart';
import 'sections/hr_hiring_compliance_primary_content_section.dart';
import 'sections/hr_hiring_compliance_action_bar_section.dart';

class HrHiringComplianceScreen extends StatelessWidget {
  const HrHiringComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_compliance',
      title: 'HrHiringComplianceScreen',
      child: Column(
        children: const [
          const HrHiringComplianceHeaderSection(),
          const HrHiringComplianceContentSummarySection(),
          const HrHiringCompliancePrimaryContentSection(),
          const HrHiringComplianceActionBarSection(),
        ],
      ),
    );
  }
}
