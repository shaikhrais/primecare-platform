import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'corrective_action_screen_controller.dart';
import 'sections/corrective_action_header_section.dart';
import 'sections/corrective_action_task_filters_section.dart';
import 'sections/corrective_action_task_list_section.dart';
import 'sections/corrective_action_task_details_section.dart';
import 'sections/corrective_action_action_bar_section.dart';


class CorrectiveActionScreen extends ConsumerWidget {
  const CorrectiveActionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(corrective_actionControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CorrectiveAction'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(corrective_actionControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('corrective_action_loading'), child: Semantics(label: 'corrective_action_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('corrective_action_screen'),
                    child: Column(
                      children: [
                        CorrectiveActionHeaderSection(data: state.data),
                        CorrectiveActionTaskFiltersSection(data: state.data),
                        CorrectiveActionTaskListSection(data: state.data),
                        CorrectiveActionTaskDetailsSection(data: state.data),
                        CorrectiveActionActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
