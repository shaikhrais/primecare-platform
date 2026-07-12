import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'invoice_management_screen_controller.dart';
import 'sections/invoice_management_header_section.dart';
import 'sections/invoice_management_content_summary_section.dart';
import 'sections/invoice_management_primary_content_section.dart';
import 'sections/invoice_management_action_bar_section.dart';


class InvoiceManagementScreen extends ConsumerWidget {
  const InvoiceManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(invoice_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('InvoiceManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(invoice_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('invoice_management_loading'), child: Semantics(label: 'invoice_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('invoice_management_screen'),
                    child: Column(
                      children: [
                        InvoiceManagementHeaderSection(data: state.data),
                        InvoiceManagementContentSummarySection(data: state.data),
                        InvoiceManagementPrimaryContentSection(data: state.data),
                        InvoiceManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
