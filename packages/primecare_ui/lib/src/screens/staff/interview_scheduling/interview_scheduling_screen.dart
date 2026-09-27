import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'interview_scheduling_screen_controller.dart';
import 'sections/interview_scheduling_header_section.dart';
import 'sections/interview_scheduling_filter_bar_section.dart';
import 'sections/interview_scheduling_data_table_section.dart';
import 'sections/interview_scheduling_pagination_section.dart';
import 'sections/interview_scheduling_action_bar_section.dart';


class InterviewSchedulingScreen extends ConsumerWidget {
  const InterviewSchedulingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(interview_schedulingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('InterviewScheduling'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(interview_schedulingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('interview_scheduling_loading'), child: Semantics(label: 'interview_scheduling_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('interview_scheduling_screen'),
                    child: Column(
                      children: [
                        InterviewSchedulingHeaderSection(data: state.data),
                        InterviewSchedulingFilterBarSection(data: state.data),
                        InterviewSchedulingDataTableSection(data: state.data),
                        InterviewSchedulingPaginationSection(data: state.data),
                        InterviewSchedulingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
