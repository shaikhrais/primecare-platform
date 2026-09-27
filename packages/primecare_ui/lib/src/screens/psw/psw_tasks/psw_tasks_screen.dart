import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_tasks_screen_controller.dart';
import 'sections/psw_tasks_header_section.dart';
import 'sections/psw_tasks_calendar_controls_section.dart';
import 'sections/psw_tasks_schedule_list_section.dart';
import 'sections/psw_tasks_appointment_details_section.dart';
import 'sections/psw_tasks_action_bar_section.dart';


class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_tasksControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Task List'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_tasksControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_tasks_loading'), child: Semantics(label: 'psw_tasks_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_tasks_screen'),
                    child: Column(
                      children: [
                        PswTasksHeaderSection(data: state.data),
                        PswTasksCalendarControlsSection(data: state.data),
                        PswTasksScheduleListSection(data: state.data),
                        PswTasksAppointmentDetailsSection(data: state.data),
                        PswTasksActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef PswTasksScreen = TaskListScreen;
