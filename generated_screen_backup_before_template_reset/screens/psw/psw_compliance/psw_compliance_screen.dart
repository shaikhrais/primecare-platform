import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_compliance_header_section.dart';
import 'sections/psw_compliance_content_summary_section.dart';
import 'sections/psw_compliance_primary_content_section.dart';
import 'sections/psw_compliance_action_bar_section.dart';

class PswComplianceScreen extends StatelessWidget {
  const PswComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_compliance',
      title: 'Psw Compliance',
      child: Column(
        children: const [
          const PswComplianceHeaderSection(),
          const PswComplianceContentSummarySection(),
          const PswCompliancePrimaryContentSection(),
          const PswComplianceActionBarSection(),
        ],
      ),
    );
  }
}
