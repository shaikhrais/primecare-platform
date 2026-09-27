import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_exercise_plan_screen_controller.dart';
import 'sections/physiotherapist_exercise_plan_header_section.dart';
import 'sections/physiotherapist_exercise_plan_content_summary_section.dart';
import 'sections/physiotherapist_exercise_plan_primary_content_section.dart';
import 'sections/physiotherapist_exercise_plan_action_bar_section.dart';


class PhysiotherapistExercisePlanScreen extends ConsumerWidget {
  const PhysiotherapistExercisePlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_exercise_planControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistExercisePlan'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_exercise_planControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_exercise_plan_loading'), child: Semantics(label: 'physiotherapist_exercise_plan_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_exercise_plan_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistExercisePlanHeaderSection(data: state.data),
                        PhysiotherapistExercisePlanContentSummarySection(data: state.data),
                        PhysiotherapistExercisePlanPrimaryContentSection(data: state.data),
                        PhysiotherapistExercisePlanActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
