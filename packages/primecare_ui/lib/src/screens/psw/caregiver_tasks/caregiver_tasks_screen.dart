import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'caregiver_tasks_screen_controller.dart';
import 'sections/caregiver_tasks_header_section.dart';
import 'sections/caregiver_tasks_task_filters_section.dart';
import 'sections/caregiver_tasks_task_list_section.dart';
import 'sections/caregiver_tasks_task_details_section.dart';
import 'sections/caregiver_tasks_action_bar_section.dart';


class CaregiverTasksScreen extends ConsumerWidget {
  const CaregiverTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caregiver_tasksControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CaregiverTasks'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(caregiver_tasksControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('caregiver_tasks_loading'), child: Semantics(label: 'caregiver_tasks_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('caregiver_tasks_screen'),
                    child: Column(
                      children: [
                        CaregiverTasksHeaderSection(data: state.data),
                        CaregiverTasksTaskFiltersSection(data: state.data),
                        CaregiverTasksTaskListSection(data: state.data),
                        CaregiverTasksTaskDetailsSection(data: state.data),
                        CaregiverTasksActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
