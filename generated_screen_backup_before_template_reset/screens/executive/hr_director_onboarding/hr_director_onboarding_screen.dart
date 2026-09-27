import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_onboarding_header_section.dart';
import 'sections/hr_director_onboarding_content_summary_section.dart';
import 'sections/hr_director_onboarding_primary_content_section.dart';
import 'sections/hr_director_onboarding_action_bar_section.dart';

class HrDirectorOnboardingScreen extends StatelessWidget {
  const HrDirectorOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_onboarding',
      title: 'HrDirectorOnboardingScreen',
      child: Column(
        children: const [
          const HrDirectorOnboardingHeaderSection(),
          const HrDirectorOnboardingContentSummarySection(),
          const HrDirectorOnboardingPrimaryContentSection(),
          const HrDirectorOnboardingActionBarSection(),
        ],
      ),
    );
  }
}
