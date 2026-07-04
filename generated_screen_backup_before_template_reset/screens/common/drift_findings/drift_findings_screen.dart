import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/drift_findings_header_section.dart';
import 'sections/drift_findings_content_summary_section.dart';
import 'sections/drift_findings_primary_content_section.dart';
import 'sections/drift_findings_action_bar_section.dart';

class DriftFindingsScreen extends StatelessWidget {
  const DriftFindingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'drift_findings',
      title: 'DriftFindingsScreen',
      child: Column(
        children: const [
          const DriftFindingsHeaderSection(),
          const DriftFindingsContentSummarySection(),
          const DriftFindingsPrimaryContentSection(),
          const DriftFindingsActionBarSection(),
        ],
      ),
    );
  }
}
