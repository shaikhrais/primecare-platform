import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_outreach_header_section.dart';
import 'sections/partnership_manager_outreach_content_summary_section.dart';
import 'sections/partnership_manager_outreach_primary_content_section.dart';
import 'sections/partnership_manager_outreach_action_bar_section.dart';

class PartnershipManagerOutreachScreen extends StatelessWidget {
  const PartnershipManagerOutreachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_outreach',
      title: 'Partnership Manager Outreach',
      child: Column(
        children: const [
          const PartnershipManagerOutreachHeaderSection(),
          const PartnershipManagerOutreachContentSummarySection(),
          const PartnershipManagerOutreachPrimaryContentSection(),
          const PartnershipManagerOutreachActionBarSection(),
        ],
      ),
    );
  }
}
