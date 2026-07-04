import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/dynamic_compliance_header_section.dart';
import 'sections/dynamic_compliance_content_summary_section.dart';
import 'sections/dynamic_compliance_primary_content_section.dart';
import 'sections/dynamic_compliance_action_bar_section.dart';

class DynamicComplianceScreen extends StatelessWidget {
  const DynamicComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'dynamic_compliance',
      title: 'DynamicScreenComplianceScreen',
      child: Column(
        children: const [
          const DynamicComplianceHeaderSection(),
          const DynamicComplianceContentSummarySection(),
          const DynamicCompliancePrimaryContentSection(),
          const DynamicComplianceActionBarSection(),
        ],
      ),
    );
  }
}
