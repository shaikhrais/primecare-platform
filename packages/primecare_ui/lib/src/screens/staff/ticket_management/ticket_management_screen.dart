import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'ticket_management_screen_controller.dart';
import 'sections/ticket_management_header_section.dart';
import 'sections/ticket_management_content_summary_section.dart';
import 'sections/ticket_management_primary_content_section.dart';
import 'sections/ticket_management_action_bar_section.dart';


class TicketManagementScreen extends ConsumerWidget {
  const TicketManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ticket_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TicketManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(ticket_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('ticket_management_loading'), child: Semantics(label: 'ticket_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('ticket_management_screen'),
                    child: Column(
                      children: [
                        TicketManagementHeaderSection(data: state.data),
                        TicketManagementContentSummarySection(data: state.data),
                        TicketManagementPrimaryContentSection(data: state.data),
                        TicketManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
