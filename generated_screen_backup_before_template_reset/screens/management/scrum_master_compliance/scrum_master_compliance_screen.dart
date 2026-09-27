import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scrum_master_compliance_header_section.dart';
import 'sections/scrum_master_compliance_content_summary_section.dart';
import 'sections/scrum_master_compliance_primary_content_section.dart';
import 'sections/scrum_master_compliance_action_bar_section.dart';

class ScrumMasterComplianceScreen extends StatelessWidget {
  const ScrumMasterComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scrum_master_compliance',
      title: 'ScrumMasterComplianceScreen',
      child: Column(
        children: const [
          const ScrumMasterComplianceHeaderSection(),
          const ScrumMasterComplianceContentSummarySection(),
          const ScrumMasterCompliancePrimaryContentSection(),
          const ScrumMasterComplianceActionBarSection(),
        ],
      ),
    );
  }
}
