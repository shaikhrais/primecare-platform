import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_system_verification_header_section.dart';
import 'sections/cto_system_verification_content_summary_section.dart';
import 'sections/cto_system_verification_primary_content_section.dart';
import 'sections/cto_system_verification_action_bar_section.dart';

class CtoSystemVerificationScreen extends StatelessWidget {
  const CtoSystemVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_system_verification',
      title: 'Cto System Verification',
      child: Column(
        children: const [
          const CtoSystemVerificationHeaderSection(),
          const CtoSystemVerificationContentSummarySection(),
          const CtoSystemVerificationPrimaryContentSection(),
          const CtoSystemVerificationActionBarSection(),
        ],
      ),
    );
  }
}
