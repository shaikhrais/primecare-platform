import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_credential_tracking_header_section.dart';
import 'sections/compliance_manager_credential_tracking_content_summary_section.dart';
import 'sections/compliance_manager_credential_tracking_primary_content_section.dart';
import 'sections/compliance_manager_credential_tracking_action_bar_section.dart';

class ComplianceManagerCredentialTrackingScreen extends StatelessWidget {
  const ComplianceManagerCredentialTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_credential_tracking',
      title: 'Compliance Manager Credential Tracking',
      child: Column(
        children: const [
          const ComplianceManagerCredentialTrackingHeaderSection(),
          const ComplianceManagerCredentialTrackingContentSummarySection(),
          const ComplianceManagerCredentialTrackingPrimaryContentSection(),
          const ComplianceManagerCredentialTrackingActionBarSection(),
        ],
      ),
    );
  }
}
