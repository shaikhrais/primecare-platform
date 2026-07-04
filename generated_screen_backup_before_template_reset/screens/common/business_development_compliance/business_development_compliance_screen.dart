import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/business_development_compliance_header_section.dart';
import 'sections/business_development_compliance_content_summary_section.dart';
import 'sections/business_development_compliance_primary_content_section.dart';
import 'sections/business_development_compliance_action_bar_section.dart';

class BusinessDevelopmentComplianceScreen extends StatelessWidget {
  const BusinessDevelopmentComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'business_development_compliance',
      title: 'BusinessDevelopmentComplianceScreen',
      child: Column(
        children: const [
          const BusinessDevelopmentComplianceHeaderSection(),
          const BusinessDevelopmentComplianceContentSummarySection(),
          const BusinessDevelopmentCompliancePrimaryContentSection(),
          const BusinessDevelopmentComplianceActionBarSection(),
        ],
      ),
    );
  }
}
