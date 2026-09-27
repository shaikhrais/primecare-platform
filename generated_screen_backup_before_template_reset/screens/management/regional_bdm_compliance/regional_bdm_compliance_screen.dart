import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_compliance_header_section.dart';
import 'sections/regional_bdm_compliance_content_summary_section.dart';
import 'sections/regional_bdm_compliance_primary_content_section.dart';
import 'sections/regional_bdm_compliance_action_bar_section.dart';

class RegionalBdmComplianceScreen extends StatelessWidget {
  const RegionalBdmComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_compliance',
      title: 'RegionalBdmComplianceScreen',
      child: Column(
        children: const [
          const RegionalBdmComplianceHeaderSection(),
          const RegionalBdmComplianceContentSummarySection(),
          const RegionalBdmCompliancePrimaryContentSection(),
          const RegionalBdmComplianceActionBarSection(),
        ],
      ),
    );
  }
}
