import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/guest_compliance_header_section.dart';
import 'sections/guest_compliance_content_summary_section.dart';
import 'sections/guest_compliance_primary_content_section.dart';
import 'sections/guest_compliance_action_bar_section.dart';

class GuestComplianceScreen extends StatelessWidget {
  const GuestComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'guest_compliance',
      title: 'GuestComplianceScreen',
      child: Column(
        children: const [
          const GuestComplianceHeaderSection(),
          const GuestComplianceContentSummarySection(),
          const GuestCompliancePrimaryContentSection(),
          const GuestComplianceActionBarSection(),
        ],
      ),
    );
  }
}
