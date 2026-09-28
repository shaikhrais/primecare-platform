import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_templates_header_section.dart';
import 'sections/customer_support_templates_content_summary_section.dart';
import 'sections/customer_support_templates_primary_content_section.dart';
import 'sections/customer_support_templates_action_bar_section.dart';

class CustomerSupportTemplatesScreen extends StatelessWidget {
  const CustomerSupportTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_templates',
      title: 'Customer Support Templates',
      child: Column(
        children: const [
          const CustomerSupportTemplatesHeaderSection(),
          const CustomerSupportTemplatesContentSummarySection(),
          const CustomerSupportTemplatesPrimaryContentSection(),
          const CustomerSupportTemplatesActionBarSection(),
        ],
      ),
    );
  }
}
