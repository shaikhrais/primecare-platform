import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/legal_compliance_header_section.dart';
import 'sections/legal_compliance_content_summary_section.dart';
import 'sections/legal_compliance_primary_content_section.dart';
import 'sections/legal_compliance_action_bar_section.dart';

class LegalComplianceScreen extends StatelessWidget {
  const LegalComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'legal_compliance',
      title: 'LegalComplianceScreen',
      child: Column(
        children: const [
          const LegalComplianceHeaderSection(),
          const LegalComplianceContentSummarySection(),
          const LegalCompliancePrimaryContentSection(),
          const LegalComplianceActionBarSection(),
        ],
      ),
    );
  }
}
