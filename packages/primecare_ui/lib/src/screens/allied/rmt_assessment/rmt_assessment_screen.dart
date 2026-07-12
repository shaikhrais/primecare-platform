import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_assessment_screen_controller.dart';
import 'sections/rmt_assessment_header_section.dart';
import 'sections/rmt_assessment_content_summary_section.dart';
import 'sections/rmt_assessment_primary_content_section.dart';
import 'sections/rmt_assessment_action_bar_section.dart';


class RmtAssessmentScreen extends ConsumerWidget {
  const RmtAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_assessmentControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtAssessment'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_assessmentControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_assessment_loading'), child: Semantics(label: 'rmt_assessment_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_assessment_screen'),
                    child: Column(
                      children: [
                        RmtAssessmentHeaderSection(data: state.data),
                        RmtAssessmentContentSummarySection(data: state.data),
                        RmtAssessmentPrimaryContentSection(data: state.data),
                        RmtAssessmentActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
