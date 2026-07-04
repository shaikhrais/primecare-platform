import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/pending_task_queue_header_section.dart';
import 'sections/pending_task_queue_task_filters_section.dart';
import 'sections/pending_task_queue_task_list_section.dart';
import 'sections/pending_task_queue_task_details_section.dart';
import 'sections/pending_task_queue_action_bar_section.dart';

class PendingTaskQueueScreen extends StatelessWidget {
  const PendingTaskQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'pending_task_queue',
      title: 'PendingTaskQueueScreen',
      child: Column(
        children: const [
          const PendingTaskQueueHeaderSection(),
          const PendingTaskQueueTaskFiltersSection(),
          const PendingTaskQueueTaskListSection(),
          const PendingTaskQueueTaskDetailsSection(),
          const PendingTaskQueueActionBarSection(),
        ],
      ),
    );
  }
}
