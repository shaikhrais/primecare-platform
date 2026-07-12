import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_profile_screen_controller.dart';
import 'sections/patient_profile_header_section.dart';
import 'sections/patient_profile_identity_summary_section.dart';
import 'sections/patient_profile_details_form_section.dart';
import 'sections/patient_profile_preferences_or_documents_section.dart';
import 'sections/patient_profile_action_bar_section.dart';


class PatientProfileScreen extends ConsumerWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_profileControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientProfile'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_profileControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_profile_loading'), child: Semantics(label: 'patient_profile_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_profile_screen'),
                    child: Column(
                      children: [
                        PatientProfileHeaderSection(data: state.data),
                        PatientProfileIdentitySummarySection(data: state.data),
                        PatientProfileDetailsFormSection(data: state.data),
                        PatientProfilePreferencesOrDocumentsSection(data: state.data),
                        PatientProfileActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
