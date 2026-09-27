import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractic_assessment_screen_controller.dart';
import 'sections/chiropractic_assessment_header_section.dart';
import 'sections/chiropractic_assessment_content_summary_section.dart';
import 'sections/chiropractic_assessment_primary_content_section.dart';
import 'sections/chiropractic_assessment_action_bar_section.dart';


class ChiropracticAssessmentScreen extends ConsumerWidget {
  const ChiropracticAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractic_assessmentControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropracticAssessment'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractic_assessmentControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractic_assessment_loading'), child: Semantics(label: 'chiropractic_assessment_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractic_assessment_screen'),
                    child: Column(
                      children: [
                        ChiropracticAssessmentHeaderSection(data: state.data),
                        ChiropracticAssessmentContentSummarySection(data: state.data),
                        ChiropracticAssessmentPrimaryContentSection(data: state.data),
                        ChiropracticAssessmentActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
