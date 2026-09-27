import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_onboarding_header_section.dart';
import 'sections/hr_hiring_onboarding_content_summary_section.dart';
import 'sections/hr_hiring_onboarding_primary_content_section.dart';
import 'sections/hr_hiring_onboarding_action_bar_section.dart';

class HrHiringOnboardingScreen extends StatelessWidget {
  const HrHiringOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_onboarding',
      title: 'HrHiringOnboardingScreen',
      child: Column(
        children: const [
          const HrHiringOnboardingHeaderSection(),
          const HrHiringOnboardingContentSummarySection(),
          const HrHiringOnboardingPrimaryContentSection(),
          const HrHiringOnboardingActionBarSection(),
        ],
      ),
    );
  }
}
