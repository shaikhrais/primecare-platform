import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/portal_compliance_header_section.dart';
import 'sections/portal_compliance_content_summary_section.dart';
import 'sections/portal_compliance_primary_content_section.dart';
import 'sections/portal_compliance_action_bar_section.dart';

class PortalComplianceScreen extends StatelessWidget {
  const PortalComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'portal_compliance',
      title: 'PortalComplianceScreen',
      child: Column(
        children: const [
          const PortalComplianceHeaderSection(),
          const PortalComplianceContentSummarySection(),
          const PortalCompliancePrimaryContentSection(),
          const PortalComplianceActionBarSection(),
        ],
      ),
    );
  }
}
