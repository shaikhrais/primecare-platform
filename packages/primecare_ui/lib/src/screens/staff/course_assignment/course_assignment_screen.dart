import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'course_assignment_screen_controller.dart';
import 'sections/course_assignment_header_section.dart';
import 'sections/course_assignment_content_summary_section.dart';
import 'sections/course_assignment_primary_content_section.dart';
import 'sections/course_assignment_action_bar_section.dart';


class CourseAssignmentScreen extends ConsumerWidget {
  const CourseAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(course_assignmentControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CourseAssignment'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(course_assignmentControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('course_assignment_loading'), child: Semantics(label: 'course_assignment_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('course_assignment_screen'),
                    child: Column(
                      children: [
                        CourseAssignmentHeaderSection(data: state.data),
                        CourseAssignmentContentSummarySection(data: state.data),
                        CourseAssignmentPrimaryContentSection(data: state.data),
                        CourseAssignmentActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
