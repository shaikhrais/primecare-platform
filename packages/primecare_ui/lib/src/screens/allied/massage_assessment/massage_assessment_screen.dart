import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'massage_assessment_screen_controller.dart';
import 'sections/massage_assessment_header_section.dart';
import 'sections/massage_assessment_content_summary_section.dart';
import 'sections/massage_assessment_primary_content_section.dart';
import 'sections/massage_assessment_action_bar_section.dart';


class MassageAssessmentScreen extends ConsumerWidget {
  const MassageAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(massage_assessmentControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('MassageAssessment'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(massage_assessmentControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('massage_assessment_loading'), child: Semantics(label: 'massage_assessment_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('massage_assessment_screen'),
                    child: Column(
                      children: [
                        MassageAssessmentHeaderSection(data: state.data),
                        MassageAssessmentContentSummarySection(data: state.data),
                        MassageAssessmentPrimaryContentSection(data: state.data),
                        MassageAssessmentActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
