import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_assessment_screen_controller.dart';
import 'sections/physiotherapist_assessment_header_section.dart';
import 'sections/physiotherapist_assessment_content_summary_section.dart';
import 'sections/physiotherapist_assessment_primary_content_section.dart';
import 'sections/physiotherapist_assessment_action_bar_section.dart';


class PhysiotherapistAssessmentScreen extends ConsumerWidget {
  const PhysiotherapistAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_assessmentControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistAssessment'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_assessmentControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_assessment_loading'), child: Semantics(label: 'physiotherapist_assessment_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_assessment_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistAssessmentHeaderSection(data: state.data),
                        PhysiotherapistAssessmentContentSummarySection(data: state.data),
                        PhysiotherapistAssessmentPrimaryContentSection(data: state.data),
                        PhysiotherapistAssessmentActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
