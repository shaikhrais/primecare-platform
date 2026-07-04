import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/receptionist_compliance_header_section.dart';
import 'sections/receptionist_compliance_content_summary_section.dart';
import 'sections/receptionist_compliance_primary_content_section.dart';
import 'sections/receptionist_compliance_action_bar_section.dart';

class ReceptionistComplianceScreen extends StatelessWidget {
  const ReceptionistComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'receptionist_compliance',
      title: 'ReceptionistComplianceScreen',
      child: Column(
        children: const [
          const ReceptionistComplianceHeaderSection(),
          const ReceptionistComplianceContentSummarySection(),
          const ReceptionistCompliancePrimaryContentSection(),
          const ReceptionistComplianceActionBarSection(),
        ],
      ),
    );
  }
}
