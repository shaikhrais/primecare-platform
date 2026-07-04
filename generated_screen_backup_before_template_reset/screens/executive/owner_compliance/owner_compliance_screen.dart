import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/owner_compliance_header_section.dart';
import 'sections/owner_compliance_content_summary_section.dart';
import 'sections/owner_compliance_primary_content_section.dart';
import 'sections/owner_compliance_action_bar_section.dart';

class OwnerComplianceScreen extends StatelessWidget {
  const OwnerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'owner_compliance',
      title: 'OwnerComplianceScreen',
      child: Column(
        children: const [
          const OwnerComplianceHeaderSection(),
          const OwnerComplianceContentSummarySection(),
          const OwnerCompliancePrimaryContentSection(),
          const OwnerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
