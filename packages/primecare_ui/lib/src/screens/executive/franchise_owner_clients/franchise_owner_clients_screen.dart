import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_owner_clients_screen_controller.dart';
import 'sections/franchise_owner_clients_header_section.dart';
import 'sections/franchise_owner_clients_content_summary_section.dart';
import 'sections/franchise_owner_clients_primary_content_section.dart';
import 'sections/franchise_owner_clients_action_bar_section.dart';


class FranchiseOwnerClientsScreen extends ConsumerWidget {
  const FranchiseOwnerClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_owner_clientsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseOwnerClients'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_owner_clientsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_owner_clients_loading'), child: Semantics(label: 'franchise_owner_clients_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_owner_clients_screen'),
                    child: Column(
                      children: [
                        FranchiseOwnerClientsHeaderSection(data: state.data),
                        FranchiseOwnerClientsContentSummarySection(data: state.data),
                        FranchiseOwnerClientsPrimaryContentSection(data: state.data),
                        FranchiseOwnerClientsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
