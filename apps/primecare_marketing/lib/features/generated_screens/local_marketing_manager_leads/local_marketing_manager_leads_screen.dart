import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/local_marketing_manager_leads_header_section.dart';
import 'sections/local_marketing_manager_leads_content_summary_section.dart';
import 'sections/local_marketing_manager_leads_primary_content_section.dart';
import 'sections/local_marketing_manager_leads_action_bar_section.dart';

class LocalMarketingManagerLeadsScreen extends StatelessWidget {
  const LocalMarketingManagerLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'local_marketing_manager_leads',
      title: 'Local Marketing Manager Leads',
      child: Column(
        children: const [
          const LocalMarketingManagerLeadsHeaderSection(),
          const LocalMarketingManagerLeadsContentSummarySection(),
          const LocalMarketingManagerLeadsPrimaryContentSection(),
          const LocalMarketingManagerLeadsActionBarSection(),
        ],
      ),
    );
  }
}
