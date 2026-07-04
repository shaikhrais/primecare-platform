import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_follow_up_header_section.dart';
import 'sections/intake_coordinator_follow_up_content_summary_section.dart';
import 'sections/intake_coordinator_follow_up_primary_content_section.dart';
import 'sections/intake_coordinator_follow_up_action_bar_section.dart';

class IntakeCoordinatorFollowUpScreen extends StatelessWidget {
  const IntakeCoordinatorFollowUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_follow_up',
      title: 'IntakeCoordinatorFollowUpScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorFollowUpHeaderSection(),
          const IntakeCoordinatorFollowUpContentSummarySection(),
          const IntakeCoordinatorFollowUpPrimaryContentSection(),
          const IntakeCoordinatorFollowUpActionBarSection(),
        ],
      ),
    );
  }
}
