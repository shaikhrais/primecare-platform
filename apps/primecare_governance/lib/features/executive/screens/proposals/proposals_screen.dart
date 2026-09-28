import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/proposals_header_section.dart';
import 'sections/proposals_content_summary_section.dart';
import 'sections/proposals_primary_content_section.dart';
import 'sections/proposals_action_bar_section.dart';

class ProposalsScreen extends StatelessWidget {
  const ProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'proposals',
      title: 'Proposals',
      child: Column(
        children: const [
          const ProposalsHeaderSection(),
          const ProposalsContentSummarySection(),
          const ProposalsPrimaryContentSection(),
          const ProposalsActionBarSection(),
        ],
      ),
    );
  }
}
