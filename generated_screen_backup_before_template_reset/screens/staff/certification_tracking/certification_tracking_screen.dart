import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/certification_tracking_header_section.dart';
import 'sections/certification_tracking_content_summary_section.dart';
import 'sections/certification_tracking_primary_content_section.dart';
import 'sections/certification_tracking_action_bar_section.dart';

class CertificationTrackingScreen extends StatelessWidget {
  const CertificationTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'certification_tracking',
      title: 'CertificationTrackingScreen',
      child: Column(
        children: const [
          const CertificationTrackingHeaderSection(),
          const CertificationTrackingContentSummarySection(),
          const CertificationTrackingPrimaryContentSection(),
          const CertificationTrackingActionBarSection(),
        ],
      ),
    );
  }
}
