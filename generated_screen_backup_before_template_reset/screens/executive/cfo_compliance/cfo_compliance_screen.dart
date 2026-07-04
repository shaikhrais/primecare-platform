import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_compliance_header_section.dart';
import 'sections/cfo_compliance_content_summary_section.dart';
import 'sections/cfo_compliance_primary_content_section.dart';
import 'sections/cfo_compliance_action_bar_section.dart';

class CfoComplianceScreen extends StatelessWidget {
  const CfoComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_compliance',
      title: 'CfoComplianceScreen',
      child: Column(
        children: const [
          const CfoComplianceHeaderSection(),
          const CfoComplianceContentSummarySection(),
          const CfoCompliancePrimaryContentSection(),
          const CfoComplianceActionBarSection(),
        ],
      ),
    );
  }
}
