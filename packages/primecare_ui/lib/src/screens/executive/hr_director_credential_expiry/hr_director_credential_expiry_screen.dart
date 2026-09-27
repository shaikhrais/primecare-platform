import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_director_credential_expiry_screen_controller.dart';
import 'sections/hr_director_credential_expiry_header_section.dart';
import 'sections/hr_director_credential_expiry_content_summary_section.dart';
import 'sections/hr_director_credential_expiry_primary_content_section.dart';
import 'sections/hr_director_credential_expiry_action_bar_section.dart';


class HrDirectorCredentialExpiryScreen extends ConsumerWidget {
  const HrDirectorCredentialExpiryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_director_credential_expiryControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrDirectorCredentialExpiry'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_director_credential_expiryControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_director_credential_expiry_loading'), child: Semantics(label: 'hr_director_credential_expiry_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_director_credential_expiry_screen'),
                    child: Column(
                      children: [
                        HrDirectorCredentialExpiryHeaderSection(data: state.data),
                        HrDirectorCredentialExpiryContentSummarySection(data: state.data),
                        HrDirectorCredentialExpiryPrimaryContentSection(data: state.data),
                        HrDirectorCredentialExpiryActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
