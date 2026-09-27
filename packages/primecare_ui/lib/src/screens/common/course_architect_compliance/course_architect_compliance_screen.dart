import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'course_architect_compliance_screen_controller.dart';
import 'sections/course_architect_compliance_header_section.dart';
import 'sections/course_architect_compliance_filter_bar_section.dart';
import 'sections/course_architect_compliance_data_table_section.dart';
import 'sections/course_architect_compliance_pagination_section.dart';
import 'sections/course_architect_compliance_action_bar_section.dart';


class CourseArchitectComplianceScreen extends ConsumerWidget {
  const CourseArchitectComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(course_architect_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CourseArchitectCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(course_architect_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('course_architect_compliance_loading'), child: Semantics(label: 'course_architect_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('course_architect_compliance_screen'),
                    child: Column(
                      children: [
                        CourseArchitectComplianceHeaderSection(data: state.data),
                        CourseArchitectComplianceFilterBarSection(data: state.data),
                        CourseArchitectComplianceDataTableSection(data: state.data),
                        CourseArchitectCompliancePaginationSection(data: state.data),
                        CourseArchitectComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
