import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_proposals_header_section.dart';
import 'sections/partnership_manager_proposals_content_summary_section.dart';
import 'sections/partnership_manager_proposals_primary_content_section.dart';
import 'sections/partnership_manager_proposals_action_bar_section.dart';

class PartnershipManagerProposalsScreen extends StatelessWidget {
  const PartnershipManagerProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_proposals',
      title: 'Partnership Manager Proposals',
      child: Column(
        children: const [
          const PartnershipManagerProposalsHeaderSection(),
          const PartnershipManagerProposalsContentSummarySection(),
          const PartnershipManagerProposalsPrimaryContentSection(),
          const PartnershipManagerProposalsActionBarSection(),
        ],
      ),
    );
  }
}
