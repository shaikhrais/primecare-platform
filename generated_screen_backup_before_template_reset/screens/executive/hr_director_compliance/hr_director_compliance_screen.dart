import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_compliance_header_section.dart';
import 'sections/hr_director_compliance_content_summary_section.dart';
import 'sections/hr_director_compliance_primary_content_section.dart';
import 'sections/hr_director_compliance_action_bar_section.dart';

class HrDirectorComplianceScreen extends StatelessWidget {
  const HrDirectorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_compliance',
      title: 'HrDirectorComplianceScreen',
      child: Column(
        children: const [
          const HrDirectorComplianceHeaderSection(),
          const HrDirectorComplianceContentSummarySection(),
          const HrDirectorCompliancePrimaryContentSection(),
          const HrDirectorComplianceActionBarSection(),
        ],
      ),
    );
  }
}
