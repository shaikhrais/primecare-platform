import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/substance_abuse_prevention_tracker_header_section.dart';
import 'sections/substance_abuse_prevention_tracker_content_summary_section.dart';
import 'sections/substance_abuse_prevention_tracker_primary_content_section.dart';
import 'sections/substance_abuse_prevention_tracker_action_bar_section.dart';

class SubstanceAbusePreventionTrackerScreen extends StatelessWidget {
  const SubstanceAbusePreventionTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'substance_abuse_prevention_tracker',
      title: 'Substance Abuse Prevention Tracker',
      child: Column(
        children: const [
          const SubstanceAbusePreventionTrackerHeaderSection(),
          const SubstanceAbusePreventionTrackerContentSummarySection(),
          const SubstanceAbusePreventionTrackerPrimaryContentSection(),
          const SubstanceAbusePreventionTrackerActionBarSection(),
        ],
      ),
    );
  }
}
