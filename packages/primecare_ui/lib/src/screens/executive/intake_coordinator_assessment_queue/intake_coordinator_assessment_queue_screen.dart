import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_coordinator_assessment_queue_screen_controller.dart';
import 'sections/intake_coordinator_assessment_queue_header_section.dart';
import 'sections/intake_coordinator_assessment_queue_content_summary_section.dart';
import 'sections/intake_coordinator_assessment_queue_primary_content_section.dart';
import 'sections/intake_coordinator_assessment_queue_action_bar_section.dart';


class IntakeCoordinatorAssessmentQueueScreen extends ConsumerWidget {
  const IntakeCoordinatorAssessmentQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_coordinator_assessment_queueControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeCoordinatorAssessmentQueue'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_coordinator_assessment_queueControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_coordinator_assessment_queue_loading'), child: Semantics(label: 'intake_coordinator_assessment_queue_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_coordinator_assessment_queue_screen'),
                    child: Column(
                      children: [
                        IntakeCoordinatorAssessmentQueueHeaderSection(data: state.data),
                        IntakeCoordinatorAssessmentQueueContentSummarySection(data: state.data),
                        IntakeCoordinatorAssessmentQueuePrimaryContentSection(data: state.data),
                        IntakeCoordinatorAssessmentQueueActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
