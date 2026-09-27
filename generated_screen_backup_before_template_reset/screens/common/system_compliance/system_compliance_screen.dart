import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/system_compliance_header_section.dart';
import 'sections/system_compliance_content_summary_section.dart';
import 'sections/system_compliance_primary_content_section.dart';
import 'sections/system_compliance_action_bar_section.dart';

class SystemComplianceScreen extends StatelessWidget {
  const SystemComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'system_compliance',
      title: 'SystemComplianceScreen',
      child: Column(
        children: const [
          const SystemComplianceHeaderSection(),
          const SystemComplianceContentSummarySection(),
          const SystemCompliancePrimaryContentSection(),
          const SystemComplianceActionBarSection(),
        ],
      ),
    );
  }
}
