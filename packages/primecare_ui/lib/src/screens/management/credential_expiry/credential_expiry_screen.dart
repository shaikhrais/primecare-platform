import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'credential_expiry_screen_controller.dart';
import 'sections/credential_expiry_header_section.dart';
import 'sections/credential_expiry_content_summary_section.dart';
import 'sections/credential_expiry_primary_content_section.dart';
import 'sections/credential_expiry_action_bar_section.dart';


class CredentialExpiryScreen extends ConsumerWidget {
  const CredentialExpiryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(credential_expiryControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CredentialExpiry'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(credential_expiryControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('credential_expiry_loading'), child: Semantics(label: 'credential_expiry_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('credential_expiry_screen'),
                    child: Column(
                      children: [
                        CredentialExpiryHeaderSection(data: state.data),
                        CredentialExpiryContentSummarySection(data: state.data),
                        CredentialExpiryPrimaryContentSection(data: state.data),
                        CredentialExpiryActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
