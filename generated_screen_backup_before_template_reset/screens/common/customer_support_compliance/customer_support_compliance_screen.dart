import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_compliance_header_section.dart';
import 'sections/customer_support_compliance_content_summary_section.dart';
import 'sections/customer_support_compliance_primary_content_section.dart';
import 'sections/customer_support_compliance_action_bar_section.dart';

class CustomerSupportComplianceScreen extends StatelessWidget {
  const CustomerSupportComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_compliance',
      title: 'CustomerSupportComplianceScreen',
      child: Column(
        children: const [
          const CustomerSupportComplianceHeaderSection(),
          const CustomerSupportComplianceContentSummarySection(),
          const CustomerSupportCompliancePrimaryContentSection(),
          const CustomerSupportComplianceActionBarSection(),
        ],
      ),
    );
  }
}
