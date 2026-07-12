import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_observation_screen_controller.dart';
import 'sections/patient_observation_header_section.dart';
import 'sections/patient_observation_content_summary_section.dart';
import 'sections/patient_observation_primary_content_section.dart';
import 'sections/patient_observation_action_bar_section.dart';


class PatientObservationScreen extends ConsumerWidget {
  const PatientObservationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_observationControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientObservation'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_observationControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_observation_loading'), child: Semantics(label: 'patient_observation_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_observation_screen'),
                    child: Column(
                      children: [
                        PatientObservationHeaderSection(data: state.data),
                        PatientObservationContentSummarySection(data: state.data),
                        PatientObservationPrimaryContentSection(data: state.data),
                        PatientObservationActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
