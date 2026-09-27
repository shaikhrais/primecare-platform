import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/governance_operations4_k_header_section.dart';
import 'sections/governance_operations4_k_content_summary_section.dart';
import 'sections/governance_operations4_k_primary_content_section.dart';
import 'sections/governance_operations4_k_action_bar_section.dart';

class GovernanceOperations4KScreen extends StatelessWidget {
  const GovernanceOperations4KScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'governance_operations4_k',
      title: 'GovernanceOperations4KScreen',
      child: Column(
        children: const [
          const GovernanceOperations4KHeaderSection(),
          const GovernanceOperations4KContentSummarySection(),
          const GovernanceOperations4KPrimaryContentSection(),
          const GovernanceOperations4KActionBarSection(),
        ],
      ),
    );
  }
}
