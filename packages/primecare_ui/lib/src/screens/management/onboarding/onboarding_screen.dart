import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'onboarding_screen_controller.dart';
import 'sections/onboarding_header_section.dart';
import 'sections/onboarding_content_summary_section.dart';
import 'sections/onboarding_primary_content_section.dart';
import 'sections/onboarding_action_bar_section.dart';


class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Onboarding'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(onboardingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('onboarding_loading'), child: Semantics(label: 'onboarding_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('onboarding_screen'),
                    child: Column(
                      children: [
                        OnboardingHeaderSection(data: state.data),
                        OnboardingContentSummarySection(data: state.data),
                        OnboardingPrimaryContentSection(data: state.data),
                        OnboardingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
