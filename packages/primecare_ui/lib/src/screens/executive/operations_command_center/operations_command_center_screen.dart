import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'operations_command_center_screen_controller.dart';
import 'sections/operations_command_center_header_section.dart';
import 'sections/operations_command_center_content_summary_section.dart';
import 'sections/operations_command_center_primary_content_section.dart';
import 'sections/operations_command_center_action_bar_section.dart';


class OperationsCommandCenterScreen extends ConsumerWidget {
  const OperationsCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operations_command_centerControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OperationsCommandCenter'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(operations_command_centerControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('operations_command_center_loading'), child: Semantics(label: 'operations_command_center_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('operations_command_center_screen'),
                    child: Column(
                      children: [
                        OperationsCommandCenterHeaderSection(data: state.data),
                        OperationsCommandCenterContentSummarySection(data: state.data),
                        OperationsCommandCenterPrimaryContentSection(data: state.data),
                        OperationsCommandCenterActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
