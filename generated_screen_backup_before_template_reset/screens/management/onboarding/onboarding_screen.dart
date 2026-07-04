import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/onboarding_header_section.dart';
import 'sections/onboarding_content_summary_section.dart';
import 'sections/onboarding_primary_content_section.dart';
import 'sections/onboarding_action_bar_section.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'onboarding',
      title: 'OnboardingScreen',
      child: Column(
        children: const [
          const OnboardingHeaderSection(),
          const OnboardingContentSummarySection(),
          const OnboardingPrimaryContentSection(),
          const OnboardingActionBarSection(),
        ],
      ),
    );
  }
}
