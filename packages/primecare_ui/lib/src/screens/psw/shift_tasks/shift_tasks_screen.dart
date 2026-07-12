import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'shift_tasks_screen_controller.dart';
import 'sections/shift_tasks_header_section.dart';
import 'sections/shift_tasks_task_filters_section.dart';
import 'sections/shift_tasks_task_list_section.dart';
import 'sections/shift_tasks_task_details_section.dart';
import 'sections/shift_tasks_action_bar_section.dart';


class ShiftTasksScreen extends ConsumerWidget {
  const ShiftTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shift_tasksControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Shift Tasks'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(shift_tasksControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('shift_tasks_loading'), child: Semantics(label: 'shift_tasks_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('shift_tasks_screen'),
                    child: Column(
                      children: [
                        ShiftTasksHeaderSection(data: state.data),
                        ShiftTasksTaskFiltersSection(data: state.data),
                        ShiftTasksTaskListSection(data: state.data),
                        ShiftTasksTaskDetailsSection(data: state.data),
                        ShiftTasksActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
