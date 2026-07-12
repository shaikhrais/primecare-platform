import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'treatment_plan_screen_controller.dart';
import 'sections/treatment_plan_header_section.dart';
import 'sections/treatment_plan_content_summary_section.dart';
import 'sections/treatment_plan_primary_content_section.dart';
import 'sections/treatment_plan_action_bar_section.dart';


class TreatmentPlanScreen extends ConsumerWidget {
  const TreatmentPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(treatment_planControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TreatmentPlan'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(treatment_planControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('treatment_plan_loading'), child: Semantics(label: 'treatment_plan_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('treatment_plan_screen'),
                    child: Column(
                      children: [
                        TreatmentPlanHeaderSection(data: state.data),
                        TreatmentPlanContentSummarySection(data: state.data),
                        TreatmentPlanPrimaryContentSection(data: state.data),
                        TreatmentPlanActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
