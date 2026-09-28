import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_leads_header_section.dart';
import 'sections/head_of_marketing_leads_content_summary_section.dart';
import 'sections/head_of_marketing_leads_primary_content_section.dart';
import 'sections/head_of_marketing_leads_action_bar_section.dart';

class HeadOfMarketingLeadsScreen extends StatelessWidget {
  const HeadOfMarketingLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_leads',
      title: 'Head Of Marketing Leads',
      child: Column(
        children: const [
          const HeadOfMarketingLeadsHeaderSection(),
          const HeadOfMarketingLeadsContentSummarySection(),
          const HeadOfMarketingLeadsPrimaryContentSection(),
          const HeadOfMarketingLeadsActionBarSection(),
        ],
      ),
    );
  }
}
