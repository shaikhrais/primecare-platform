import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'onboarding_checklist_screen_controller.dart';
import 'sections/onboarding_checklist_header_section.dart';
import 'sections/onboarding_checklist_task_filters_section.dart';
import 'sections/onboarding_checklist_task_list_section.dart';
import 'sections/onboarding_checklist_task_details_section.dart';
import 'sections/onboarding_checklist_action_bar_section.dart';


class OnboardingChecklistScreen extends ConsumerWidget {
  const OnboardingChecklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboarding_checklistControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OnboardingChecklist'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(onboarding_checklistControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('onboarding_checklist_loading'), child: Semantics(label: 'onboarding_checklist_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('onboarding_checklist_screen'),
                    child: Column(
                      children: [
                        OnboardingChecklistHeaderSection(data: state.data),
                        OnboardingChecklistTaskFiltersSection(data: state.data),
                        OnboardingChecklistTaskListSection(data: state.data),
                        OnboardingChecklistTaskDetailsSection(data: state.data),
                        OnboardingChecklistActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
