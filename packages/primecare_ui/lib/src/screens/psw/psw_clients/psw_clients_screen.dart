import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_clients_screen_controller.dart';
import 'sections/psw_clients_header_section.dart';
import 'sections/psw_clients_identity_summary_section.dart';
import 'sections/psw_clients_details_form_section.dart';
import 'sections/psw_clients_preferences_or_documents_section.dart';
import 'sections/psw_clients_action_bar_section.dart';


class MyClientsScreen extends ConsumerWidget {
  const MyClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_clientsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('My Clients'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_clientsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_clients_loading'), child: Semantics(label: 'psw_clients_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_clients_screen'),
                    child: Column(
                      children: [
                        PswClientsHeaderSection(data: state.data),
                        PswClientsIdentitySummarySection(data: state.data),
                        PswClientsDetailsFormSection(data: state.data),
                        PswClientsPreferencesOrDocumentsSection(data: state.data),
                        PswClientsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef PswClientsScreen = MyClientsScreen;
