import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/vitals_tracking_header_section.dart';
import 'sections/vitals_tracking_content_summary_section.dart';
import 'sections/vitals_tracking_primary_content_section.dart';
import 'sections/vitals_tracking_action_bar_section.dart';

class VitalsTrackingScreen extends StatelessWidget {
  const VitalsTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'vitals_tracking',
      title: 'VitalsTrackingScreen',
      child: Column(
        children: const [
          const VitalsTrackingHeaderSection(),
          const VitalsTrackingContentSummarySection(),
          const VitalsTrackingPrimaryContentSection(),
          const VitalsTrackingActionBarSection(),
        ],
      ),
    );
  }
}
