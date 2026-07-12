import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_hiring_onboarding_screen_controller.dart';
import 'sections/hr_hiring_onboarding_header_section.dart';
import 'sections/hr_hiring_onboarding_content_summary_section.dart';
import 'sections/hr_hiring_onboarding_primary_content_section.dart';
import 'sections/hr_hiring_onboarding_action_bar_section.dart';


class HrHiringOnboardingScreen extends ConsumerWidget {
  const HrHiringOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_hiring_onboardingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrHiringOnboarding'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_hiring_onboardingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_hiring_onboarding_loading'), child: Semantics(label: 'hr_hiring_onboarding_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_hiring_onboarding_screen'),
                    child: Column(
                      children: [
                        HrHiringOnboardingHeaderSection(data: state.data),
                        HrHiringOnboardingContentSummarySection(data: state.data),
                        HrHiringOnboardingPrimaryContentSection(data: state.data),
                        HrHiringOnboardingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
