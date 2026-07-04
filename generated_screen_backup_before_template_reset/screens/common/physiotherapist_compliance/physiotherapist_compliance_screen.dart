import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_compliance_header_section.dart';
import 'sections/physiotherapist_compliance_content_summary_section.dart';
import 'sections/physiotherapist_compliance_primary_content_section.dart';
import 'sections/physiotherapist_compliance_action_bar_section.dart';

class PhysiotherapistComplianceScreen extends StatelessWidget {
  const PhysiotherapistComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_compliance',
      title: 'PhysiotherapistComplianceScreen',
      child: Column(
        children: const [
          const PhysiotherapistComplianceHeaderSection(),
          const PhysiotherapistComplianceContentSummarySection(),
          const PhysiotherapistCompliancePrimaryContentSection(),
          const PhysiotherapistComplianceActionBarSection(),
        ],
      ),
    );
  }
}
