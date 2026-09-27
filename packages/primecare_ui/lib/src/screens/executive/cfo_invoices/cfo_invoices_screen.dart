import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_invoices_screen_controller.dart';
import 'sections/cfo_invoices_header_section.dart';
import 'sections/cfo_invoices_content_summary_section.dart';
import 'sections/cfo_invoices_primary_content_section.dart';
import 'sections/cfo_invoices_action_bar_section.dart';


class CfoInvoicesScreen extends ConsumerWidget {
  const CfoInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_invoicesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoInvoices'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_invoicesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_invoices_loading'), child: Semantics(label: 'cfo_invoices_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_invoices_screen'),
                    child: Column(
                      children: [
                        CfoInvoicesHeaderSection(data: state.data),
                        CfoInvoicesContentSummarySection(data: state.data),
                        CfoInvoicesPrimaryContentSection(data: state.data),
                        CfoInvoicesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
