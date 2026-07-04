import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractic_progress_tracking_header_section.dart';
import 'sections/chiropractic_progress_tracking_content_summary_section.dart';
import 'sections/chiropractic_progress_tracking_primary_content_section.dart';
import 'sections/chiropractic_progress_tracking_action_bar_section.dart';

class ChiropracticProgressTrackingScreen extends StatelessWidget {
  const ChiropracticProgressTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractic_progress_tracking',
      title: 'ChiropracticProgressTrackingScreen',
      child: Column(
        children: const [
          const ChiropracticProgressTrackingHeaderSection(),
          const ChiropracticProgressTrackingContentSummarySection(),
          const ChiropracticProgressTrackingPrimaryContentSection(),
          const ChiropracticProgressTrackingActionBarSection(),
        ],
      ),
    );
  }
}
