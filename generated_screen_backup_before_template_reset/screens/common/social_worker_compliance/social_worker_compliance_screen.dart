import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/social_worker_compliance_header_section.dart';
import 'sections/social_worker_compliance_content_summary_section.dart';
import 'sections/social_worker_compliance_primary_content_section.dart';
import 'sections/social_worker_compliance_action_bar_section.dart';

class SocialWorkerComplianceScreen extends StatelessWidget {
  const SocialWorkerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'social_worker_compliance',
      title: 'SocialWorkerComplianceScreen',
      child: Column(
        children: const [
          const SocialWorkerComplianceHeaderSection(),
          const SocialWorkerComplianceContentSummarySection(),
          const SocialWorkerCompliancePrimaryContentSection(),
          const SocialWorkerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
