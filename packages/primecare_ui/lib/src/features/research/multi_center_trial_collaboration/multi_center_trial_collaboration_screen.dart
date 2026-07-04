import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/multi_center_trial_collaboration_header_section.dart';
import 'sections/multi_center_trial_collaboration_content_summary_section.dart';
import 'sections/multi_center_trial_collaboration_primary_content_section.dart';
import 'sections/multi_center_trial_collaboration_action_bar_section.dart';

class MultiCenterTrialCollaborationScreen extends StatelessWidget {
  const MultiCenterTrialCollaborationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'multi_center_trial_collaboration',
      title: 'Multi Center Trial Collaboration',
      child: Column(
        children: const [
          const MultiCenterTrialCollaborationHeaderSection(),
          const MultiCenterTrialCollaborationContentSummarySection(),
          const MultiCenterTrialCollaborationPrimaryContentSection(),
          const MultiCenterTrialCollaborationActionBarSection(),
        ],
      ),
    );
  }
}
