import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_leads_header_section.dart';
import 'sections/regional_bdm_leads_content_summary_section.dart';
import 'sections/regional_bdm_leads_primary_content_section.dart';
import 'sections/regional_bdm_leads_action_bar_section.dart';

class RegionalBdmLeadsScreen extends StatelessWidget {
  const RegionalBdmLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_leads',
      title: 'Regional Bdm Leads',
      child: Column(
        children: const [
          const RegionalBdmLeadsHeaderSection(),
          const RegionalBdmLeadsContentSummarySection(),
          const RegionalBdmLeadsPrimaryContentSection(),
          const RegionalBdmLeadsActionBarSection(),
        ],
      ),
    );
  }
}
