import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_admin_compliance_header_section.dart';
import 'sections/billing_admin_compliance_content_summary_section.dart';
import 'sections/billing_admin_compliance_primary_content_section.dart';
import 'sections/billing_admin_compliance_action_bar_section.dart';

class BillingAdminComplianceScreen extends StatelessWidget {
  const BillingAdminComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing_admin_compliance',
      title: 'BillingAdminComplianceScreen',
      child: Column(
        children: const [
          const BillingAdminComplianceHeaderSection(),
          const BillingAdminComplianceContentSummarySection(),
          const BillingAdminCompliancePrimaryContentSection(),
          const BillingAdminComplianceActionBarSection(),
        ],
      ),
    );
  }
}
