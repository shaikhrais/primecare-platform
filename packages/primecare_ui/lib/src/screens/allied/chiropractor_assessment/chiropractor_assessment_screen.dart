import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_assessment_screen_controller.dart';
import 'sections/chiropractor_assessment_header_section.dart';
import 'sections/chiropractor_assessment_content_summary_section.dart';
import 'sections/chiropractor_assessment_primary_content_section.dart';
import 'sections/chiropractor_assessment_action_bar_section.dart';


class ChiropractorAssessmentScreen extends ConsumerWidget {
  const ChiropractorAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_assessmentControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorAssessment'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_assessmentControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_assessment_loading'), child: Semantics(label: 'chiropractor_assessment_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_assessment_screen'),
                    child: Column(
                      children: [
                        ChiropractorAssessmentHeaderSection(data: state.data),
                        ChiropractorAssessmentContentSummarySection(data: state.data),
                        ChiropractorAssessmentPrimaryContentSection(data: state.data),
                        ChiropractorAssessmentActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
