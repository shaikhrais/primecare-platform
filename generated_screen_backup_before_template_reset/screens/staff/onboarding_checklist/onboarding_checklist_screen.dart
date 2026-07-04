import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/onboarding_checklist_header_section.dart';
import 'sections/onboarding_checklist_task_filters_section.dart';
import 'sections/onboarding_checklist_task_list_section.dart';
import 'sections/onboarding_checklist_task_details_section.dart';
import 'sections/onboarding_checklist_action_bar_section.dart';

class OnboardingChecklistScreen extends StatelessWidget {
  const OnboardingChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'onboarding_checklist',
      title: 'OnboardingChecklistScreen',
      child: Column(
        children: const [
          const OnboardingChecklistHeaderSection(),
          const OnboardingChecklistTaskFiltersSection(),
          const OnboardingChecklistTaskListSection(),
          const OnboardingChecklistTaskDetailsSection(),
          const OnboardingChecklistActionBarSection(),
        ],
      ),
    );
  }
}
