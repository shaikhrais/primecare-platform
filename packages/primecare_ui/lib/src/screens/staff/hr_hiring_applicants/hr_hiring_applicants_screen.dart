import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_hiring_applicants_screen_controller.dart';
import 'sections/hr_hiring_applicants_header_section.dart';
import 'sections/hr_hiring_applicants_content_summary_section.dart';
import 'sections/hr_hiring_applicants_primary_content_section.dart';
import 'sections/hr_hiring_applicants_action_bar_section.dart';


class HrHiringApplicantsScreen extends ConsumerWidget {
  const HrHiringApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_hiring_applicantsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrHiringApplicants'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_hiring_applicantsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_hiring_applicants_loading'), child: Semantics(label: 'hr_hiring_applicants_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_hiring_applicants_screen'),
                    child: Column(
                      children: [
                        HrHiringApplicantsHeaderSection(data: state.data),
                        HrHiringApplicantsContentSummarySection(data: state.data),
                        HrHiringApplicantsPrimaryContentSection(data: state.data),
                        HrHiringApplicantsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
