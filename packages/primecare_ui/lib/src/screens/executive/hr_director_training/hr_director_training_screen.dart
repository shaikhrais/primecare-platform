import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_director_training_screen_controller.dart';
import 'sections/hr_director_training_header_section.dart';
import 'sections/hr_director_training_content_summary_section.dart';
import 'sections/hr_director_training_primary_content_section.dart';
import 'sections/hr_director_training_action_bar_section.dart';


class HrDirectorTrainingScreen extends ConsumerWidget {
  const HrDirectorTrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_director_trainingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrDirectorTraining'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_director_trainingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_director_training_loading'), child: Semantics(label: 'hr_director_training_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_director_training_screen'),
                    child: Column(
                      children: [
                        HrDirectorTrainingHeaderSection(data: state.data),
                        HrDirectorTrainingContentSummarySection(data: state.data),
                        HrDirectorTrainingPrimaryContentSection(data: state.data),
                        HrDirectorTrainingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
