import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'legal_compliance_screen_controller.dart';
import 'sections/legal_compliance_header_section.dart';
import 'sections/legal_compliance_content_summary_section.dart';
import 'sections/legal_compliance_primary_content_section.dart';
import 'sections/legal_compliance_action_bar_section.dart';


class LegalComplianceScreen extends ConsumerWidget {
  const LegalComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(legal_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LegalCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(legal_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('legal_compliance_loading'), child: Semantics(label: 'legal_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('legal_compliance_screen'),
                    child: Column(
                      children: [
                        LegalComplianceHeaderSection(data: state.data),
                        LegalComplianceContentSummarySection(data: state.data),
                        LegalCompliancePrimaryContentSection(data: state.data),
                        LegalComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
