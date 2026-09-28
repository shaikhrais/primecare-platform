import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/verification_center_header_section.dart';
import 'sections/verification_center_content_summary_section.dart';
import 'sections/verification_center_primary_content_section.dart';
import 'sections/verification_center_action_bar_section.dart';

class VerificationCenterScreen extends StatelessWidget {
  const VerificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'verification_center',
      title: 'Verification Center',
      child: Column(
        children: const [
          const VerificationCenterHeaderSection(),
          const VerificationCenterContentSummarySection(),
          const VerificationCenterPrimaryContentSection(),
          const VerificationCenterActionBarSection(),
        ],
      ),
    );
  }
}
