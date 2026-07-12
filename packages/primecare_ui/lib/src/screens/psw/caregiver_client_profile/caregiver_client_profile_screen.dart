import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'caregiver_client_profile_screen_controller.dart';
import 'sections/caregiver_client_profile_header_section.dart';
import 'sections/caregiver_client_profile_identity_summary_section.dart';
import 'sections/caregiver_client_profile_details_form_section.dart';
import 'sections/caregiver_client_profile_preferences_or_documents_section.dart';
import 'sections/caregiver_client_profile_action_bar_section.dart';


class CaregiverClientProfileScreen extends ConsumerWidget {
  const CaregiverClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caregiver_client_profileControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CaregiverClientProfile'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(caregiver_client_profileControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('caregiver_client_profile_loading'), child: Semantics(label: 'caregiver_client_profile_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('caregiver_client_profile_screen'),
                    child: Column(
                      children: [
                        CaregiverClientProfileHeaderSection(data: state.data),
                        CaregiverClientProfileIdentitySummarySection(data: state.data),
                        CaregiverClientProfileDetailsFormSection(data: state.data),
                        CaregiverClientProfilePreferencesOrDocumentsSection(data: state.data),
                        CaregiverClientProfileActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
