import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_assessments_screen_controller.dart';
import 'sections/rn_assessments_header_section.dart';
import 'sections/rn_assessments_content_summary_section.dart';
import 'sections/rn_assessments_primary_content_section.dart';
import 'sections/rn_assessments_action_bar_section.dart';


class RnAssessmentsScreen extends ConsumerWidget {
  const RnAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_assessmentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnAssessments'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_assessmentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_assessments_loading'), child: Semantics(label: 'rn_assessments_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_assessments_screen'),
                    child: Column(
                      children: [
                        RnAssessmentsHeaderSection(data: state.data),
                        RnAssessmentsContentSummarySection(data: state.data),
                        RnAssessmentsPrimaryContentSection(data: state.data),
                        RnAssessmentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
