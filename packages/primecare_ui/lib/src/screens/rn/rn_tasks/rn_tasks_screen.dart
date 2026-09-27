import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_tasks_screen_controller.dart';
import 'sections/rn_tasks_header_section.dart';
import 'sections/rn_tasks_task_filters_section.dart';
import 'sections/rn_tasks_task_list_section.dart';
import 'sections/rn_tasks_task_details_section.dart';
import 'sections/rn_tasks_action_bar_section.dart';


class RnTasksScreen extends ConsumerWidget {
  const RnTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_tasksControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnTasks'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_tasksControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_tasks_loading'), child: Semantics(label: 'rn_tasks_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_tasks_screen'),
                    child: Column(
                      children: [
                        RnTasksHeaderSection(data: state.data),
                        RnTasksTaskFiltersSection(data: state.data),
                        RnTasksTaskListSection(data: state.data),
                        RnTasksTaskDetailsSection(data: state.data),
                        RnTasksActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
