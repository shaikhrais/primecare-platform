import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_onboarding_header_section.dart';
import 'sections/hr_onboarding_content_summary_section.dart';
import 'sections/hr_onboarding_primary_content_section.dart';
import 'sections/hr_onboarding_action_bar_section.dart';

class HrOnboardingScreen extends StatelessWidget {
  const HrOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_onboarding',
      title: 'Hr Onboarding',
      child: Column(
        children: const [
          const HrOnboardingHeaderSection(),
          const HrOnboardingContentSummarySection(),
          const HrOnboardingPrimaryContentSection(),
          const HrOnboardingActionBarSection(),
        ],
      ),
    );
  }
}
