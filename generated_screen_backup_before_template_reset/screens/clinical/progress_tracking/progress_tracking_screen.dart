import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/progress_tracking_header_section.dart';
import 'sections/progress_tracking_content_summary_section.dart';
import 'sections/progress_tracking_primary_content_section.dart';
import 'sections/progress_tracking_action_bar_section.dart';

class ProgressTrackingScreen extends StatelessWidget {
  const ProgressTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'progress_tracking',
      title: 'ProgressTrackingScreen',
      child: Column(
        children: const [
          const ProgressTrackingHeaderSection(),
          const ProgressTrackingContentSummarySection(),
          const ProgressTrackingPrimaryContentSection(),
          const ProgressTrackingActionBarSection(),
        ],
      ),
    );
  }
}
