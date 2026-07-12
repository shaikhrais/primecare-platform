import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'exercise_prescription_screen_controller.dart';
import 'sections/exercise_prescription_header_section.dart';
import 'sections/exercise_prescription_content_summary_section.dart';
import 'sections/exercise_prescription_primary_content_section.dart';
import 'sections/exercise_prescription_action_bar_section.dart';


class ExercisePrescriptionScreen extends ConsumerWidget {
  const ExercisePrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exercise_prescriptionControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ExercisePrescription'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(exercise_prescriptionControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('exercise_prescription_loading'), child: Semantics(label: 'exercise_prescription_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('exercise_prescription_screen'),
                    child: Column(
                      children: [
                        ExercisePrescriptionHeaderSection(data: state.data),
                        ExercisePrescriptionContentSummarySection(data: state.data),
                        ExercisePrescriptionPrimaryContentSection(data: state.data),
                        ExercisePrescriptionActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
