import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_exercise_plan_screen_controller.dart';
import 'sections/rmt_exercise_plan_header_section.dart';
import 'sections/rmt_exercise_plan_content_summary_section.dart';
import 'sections/rmt_exercise_plan_primary_content_section.dart';
import 'sections/rmt_exercise_plan_action_bar_section.dart';


class RmtExercisePlanScreen extends ConsumerWidget {
  const RmtExercisePlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_exercise_planControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtExercisePlan'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_exercise_planControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_exercise_plan_loading'), child: Semantics(label: 'rmt_exercise_plan_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_exercise_plan_screen'),
                    child: Column(
                      children: [
                        RmtExercisePlanHeaderSection(data: state.data),
                        RmtExercisePlanContentSummarySection(data: state.data),
                        RmtExercisePlanPrimaryContentSection(data: state.data),
                        RmtExercisePlanActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
