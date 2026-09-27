import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/applicant_tracking_header_section.dart';
import 'sections/applicant_tracking_content_summary_section.dart';
import 'sections/applicant_tracking_primary_content_section.dart';
import 'sections/applicant_tracking_action_bar_section.dart';

class ApplicantTrackingScreen extends StatelessWidget {
  const ApplicantTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'applicant_tracking',
      title: 'ApplicantTrackingScreen',
      child: Column(
        children: const [
          const ApplicantTrackingHeaderSection(),
          const ApplicantTrackingContentSummarySection(),
          const ApplicantTrackingPrimaryContentSection(),
          const ApplicantTrackingActionBarSection(),
        ],
      ),
    );
  }
}
