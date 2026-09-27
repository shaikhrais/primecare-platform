import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_client_profile_screen_controller.dart';
import 'sections/psw_client_profile_header_section.dart';
import 'sections/psw_client_profile_identity_summary_section.dart';
import 'sections/psw_client_profile_details_form_section.dart';
import 'sections/psw_client_profile_preferences_or_documents_section.dart';
import 'sections/psw_client_profile_action_bar_section.dart';


class PswClientProfileScreen extends ConsumerWidget {
  const PswClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_client_profileControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Psw Client Profile'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_client_profileControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_client_profile_loading'), child: Semantics(label: 'psw_client_profile_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_client_profile_screen'),
                    child: Column(
                      children: [
                        PswClientProfileHeaderSection(data: state.data),
                        PswClientProfileIdentitySummarySection(data: state.data),
                        PswClientProfileDetailsFormSection(data: state.data),
                        PswClientProfilePreferencesOrDocumentsSection(data: state.data),
                        PswClientProfileActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
