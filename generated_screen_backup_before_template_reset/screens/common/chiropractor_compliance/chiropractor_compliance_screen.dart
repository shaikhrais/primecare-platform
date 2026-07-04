import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_compliance_header_section.dart';
import 'sections/chiropractor_compliance_content_summary_section.dart';
import 'sections/chiropractor_compliance_primary_content_section.dart';
import 'sections/chiropractor_compliance_action_bar_section.dart';

class ChiropractorComplianceScreen extends StatelessWidget {
  const ChiropractorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_compliance',
      title: 'ChiropractorComplianceScreen',
      child: Column(
        children: const [
          const ChiropractorComplianceHeaderSection(),
          const ChiropractorComplianceContentSummarySection(),
          const ChiropractorCompliancePrimaryContentSection(),
          const ChiropractorComplianceActionBarSection(),
        ],
      ),
    );
  }
}
