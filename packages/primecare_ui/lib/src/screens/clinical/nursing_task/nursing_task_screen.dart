import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'nursing_task_screen_controller.dart';
import 'sections/nursing_task_header_section.dart';
import 'sections/nursing_task_task_filters_section.dart';
import 'sections/nursing_task_task_list_section.dart';
import 'sections/nursing_task_task_details_section.dart';
import 'sections/nursing_task_action_bar_section.dart';


class NursingTaskScreen extends ConsumerWidget {
  const NursingTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nursing_taskControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('NursingTask'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(nursing_taskControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('nursing_task_loading'), child: Semantics(label: 'nursing_task_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('nursing_task_screen'),
                    child: Column(
                      children: [
                        NursingTaskHeaderSection(data: state.data),
                        NursingTaskTaskFiltersSection(data: state.data),
                        NursingTaskTaskListSection(data: state.data),
                        NursingTaskTaskDetailsSection(data: state.data),
                        NursingTaskActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
