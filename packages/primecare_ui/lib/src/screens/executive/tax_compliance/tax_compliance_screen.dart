import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'tax_compliance_screen_controller.dart';
import 'sections/tax_compliance_header_section.dart';
import 'sections/tax_compliance_content_summary_section.dart';
import 'sections/tax_compliance_primary_content_section.dart';
import 'sections/tax_compliance_action_bar_section.dart';


class TaxComplianceScreen extends ConsumerWidget {
  const TaxComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tax_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TaxCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(tax_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('tax_compliance_loading'), child: Semantics(label: 'tax_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('tax_compliance_screen'),
                    child: Column(
                      children: [
                        TaxComplianceHeaderSection(data: state.data),
                        TaxComplianceContentSummarySection(data: state.data),
                        TaxCompliancePrimaryContentSection(data: state.data),
                        TaxComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
