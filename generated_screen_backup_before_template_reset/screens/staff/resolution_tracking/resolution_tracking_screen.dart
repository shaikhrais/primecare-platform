import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/resolution_tracking_header_section.dart';
import 'sections/resolution_tracking_content_summary_section.dart';
import 'sections/resolution_tracking_primary_content_section.dart';
import 'sections/resolution_tracking_action_bar_section.dart';

class ResolutionTrackingScreen extends StatelessWidget {
  const ResolutionTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'resolution_tracking',
      title: 'ResolutionTrackingScreen',
      child: Column(
        children: const [
          const ResolutionTrackingHeaderSection(),
          const ResolutionTrackingContentSummarySection(),
          const ResolutionTrackingPrimaryContentSection(),
          const ResolutionTrackingActionBarSection(),
        ],
      ),
    );
  }
}
