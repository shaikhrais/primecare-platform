import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_escalations_header_section.dart';
import 'sections/customer_support_escalations_content_summary_section.dart';
import 'sections/customer_support_escalations_primary_content_section.dart';
import 'sections/customer_support_escalations_action_bar_section.dart';

class CustomerSupportEscalationsScreen extends StatelessWidget {
  const CustomerSupportEscalationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_escalations',
      title: 'Customer Support Escalations',
      child: Column(
        children: const [
          const CustomerSupportEscalationsHeaderSection(),
          const CustomerSupportEscalationsContentSummarySection(),
          const CustomerSupportEscalationsPrimaryContentSection(),
          const CustomerSupportEscalationsActionBarSection(),
        ],
      ),
    );
  }
}
