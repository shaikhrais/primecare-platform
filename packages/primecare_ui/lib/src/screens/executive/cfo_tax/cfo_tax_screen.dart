import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_tax_screen_controller.dart';
import 'sections/cfo_tax_header_section.dart';
import 'sections/cfo_tax_content_summary_section.dart';
import 'sections/cfo_tax_primary_content_section.dart';
import 'sections/cfo_tax_action_bar_section.dart';


class CfoTaxScreen extends ConsumerWidget {
  const CfoTaxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_taxControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoTax'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_taxControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_tax_loading'), child: Semantics(label: 'cfo_tax_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_tax_screen'),
                    child: Column(
                      children: [
                        CfoTaxHeaderSection(data: state.data),
                        CfoTaxContentSummarySection(data: state.data),
                        CfoTaxPrimaryContentSection(data: state.data),
                        CfoTaxActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
