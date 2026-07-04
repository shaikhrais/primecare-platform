import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/system_verification_compliance_header_section.dart';
import 'sections/system_verification_compliance_content_summary_section.dart';
import 'sections/system_verification_compliance_primary_content_section.dart';
import 'sections/system_verification_compliance_action_bar_section.dart';

class SystemVerificationComplianceScreen extends StatelessWidget {
  const SystemVerificationComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'system_verification_compliance',
      title: 'SystemVerificationComplianceScreen',
      child: Column(
        children: const [
          const SystemVerificationComplianceHeaderSection(),
          const SystemVerificationComplianceContentSummarySection(),
          const SystemVerificationCompliancePrimaryContentSection(),
          const SystemVerificationComplianceActionBarSection(),
        ],
      ),
    );
  }
}
