import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/defect_tracking_header_section.dart';
import 'sections/defect_tracking_content_summary_section.dart';
import 'sections/defect_tracking_primary_content_section.dart';
import 'sections/defect_tracking_action_bar_section.dart';

class DefectTrackingScreen extends StatelessWidget {
  const DefectTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'defect_tracking',
      title: 'DefectTrackingScreen',
      child: Column(
        children: const [
          const DefectTrackingHeaderSection(),
          const DefectTrackingContentSummarySection(),
          const DefectTrackingPrimaryContentSection(),
          const DefectTrackingActionBarSection(),
        ],
      ),
    );
  }
}
