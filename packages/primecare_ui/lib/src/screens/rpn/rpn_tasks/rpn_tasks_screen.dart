import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_tasks_screen_controller.dart';
import 'sections/rpn_tasks_header_section.dart';
import 'sections/rpn_tasks_task_filters_section.dart';
import 'sections/rpn_tasks_task_list_section.dart';
import 'sections/rpn_tasks_task_details_section.dart';
import 'sections/rpn_tasks_action_bar_section.dart';


class RpnTasksScreen extends ConsumerWidget {
  const RpnTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_tasksControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnTasks'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_tasksControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_tasks_loading'), child: Semantics(label: 'rpn_tasks_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_tasks_screen'),
                    child: Column(
                      children: [
                        RpnTasksHeaderSection(data: state.data),
                        RpnTasksTaskFiltersSection(data: state.data),
                        RpnTasksTaskListSection(data: state.data),
                        RpnTasksTaskDetailsSection(data: state.data),
                        RpnTasksActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
