import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_compliance_header_section.dart';
import 'sections/head_of_marketing_compliance_content_summary_section.dart';
import 'sections/head_of_marketing_compliance_primary_content_section.dart';
import 'sections/head_of_marketing_compliance_action_bar_section.dart';

class HeadOfMarketingComplianceScreen extends StatelessWidget {
  const HeadOfMarketingComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_compliance',
      title: 'HeadOfMarketingComplianceScreen',
      child: Column(
        children: const [
          const HeadOfMarketingComplianceHeaderSection(),
          const HeadOfMarketingComplianceContentSummarySection(),
          const HeadOfMarketingCompliancePrimaryContentSection(),
          const HeadOfMarketingComplianceActionBarSection(),
        ],
      ),
    );
  }
}
