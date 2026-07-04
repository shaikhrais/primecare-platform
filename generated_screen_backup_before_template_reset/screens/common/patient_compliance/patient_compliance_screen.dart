import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_compliance_header_section.dart';
import 'sections/patient_compliance_content_summary_section.dart';
import 'sections/patient_compliance_primary_content_section.dart';
import 'sections/patient_compliance_action_bar_section.dart';

class PatientComplianceScreen extends StatelessWidget {
  const PatientComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_compliance',
      title: 'PatientComplianceScreen',
      child: Column(
        children: const [
          const PatientComplianceHeaderSection(),
          const PatientComplianceContentSummarySection(),
          const PatientCompliancePrimaryContentSection(),
          const PatientComplianceActionBarSection(),
        ],
      ),
    );
  }
}
