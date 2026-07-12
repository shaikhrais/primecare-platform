import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_care_plan_screen_controller.dart';
import 'sections/patient_care_plan_header_section.dart';
import 'sections/patient_care_plan_content_summary_section.dart';
import 'sections/patient_care_plan_primary_content_section.dart';
import 'sections/patient_care_plan_action_bar_section.dart';


class PatientCarePlanScreen extends ConsumerWidget {
  const PatientCarePlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_care_planControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientCarePlan'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_care_planControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_care_plan_loading'), child: Semantics(label: 'patient_care_plan_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_care_plan_screen'),
                    child: Column(
                      children: [
                        PatientCarePlanHeaderSection(data: state.data),
                        PatientCarePlanContentSummarySection(data: state.data),
                        PatientCarePlanPrimaryContentSection(data: state.data),
                        PatientCarePlanActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
