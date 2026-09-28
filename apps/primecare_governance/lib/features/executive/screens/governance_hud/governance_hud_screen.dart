import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/governance_hud_header_section.dart';
import 'sections/governance_hud_content_summary_section.dart';
import 'sections/governance_hud_primary_content_section.dart';
import 'sections/governance_hud_action_bar_section.dart';

class GovernanceHudScreen extends StatelessWidget {
  const GovernanceHudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'governance_hud',
      title: 'Governance Hud',
      child: Column(
        children: const [
          const GovernanceHudHeaderSection(),
          const GovernanceHudContentSummarySection(),
          const GovernanceHudPrimaryContentSection(),
          const GovernanceHudActionBarSection(),
        ],
      ),
    );
  }
}
