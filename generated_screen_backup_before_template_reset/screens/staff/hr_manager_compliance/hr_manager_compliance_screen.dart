import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_manager_compliance_header_section.dart';
import 'sections/hr_manager_compliance_content_summary_section.dart';
import 'sections/hr_manager_compliance_primary_content_section.dart';
import 'sections/hr_manager_compliance_action_bar_section.dart';

class HrManagerComplianceScreen extends StatelessWidget {
  const HrManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_manager_compliance',
      title: 'HrManagerComplianceScreen',
      child: Column(
        children: const [
          const HrManagerComplianceHeaderSection(),
          const HrManagerComplianceContentSummarySection(),
          const HrManagerCompliancePrimaryContentSection(),
          const HrManagerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
