import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'training_management_screen_controller.dart';
import 'sections/training_management_header_section.dart';
import 'sections/training_management_content_summary_section.dart';
import 'sections/training_management_primary_content_section.dart';
import 'sections/training_management_action_bar_section.dart';


class TrainingManagementScreen extends ConsumerWidget {
  const TrainingManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(training_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TrainingManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(training_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('training_management_loading'), child: Semantics(label: 'training_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('training_management_screen'),
                    child: Column(
                      children: [
                        TrainingManagementHeaderSection(data: state.data),
                        TrainingManagementContentSummarySection(data: state.data),
                        TrainingManagementPrimaryContentSection(data: state.data),
                        TrainingManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
