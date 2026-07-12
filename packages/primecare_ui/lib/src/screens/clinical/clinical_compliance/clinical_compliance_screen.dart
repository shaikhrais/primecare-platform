import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_compliance_screen_controller.dart';
import 'sections/clinical_compliance_header_section.dart';
import 'sections/clinical_compliance_content_summary_section.dart';
import 'sections/clinical_compliance_primary_content_section.dart';
import 'sections/clinical_compliance_action_bar_section.dart';


class ClinicalComplianceScreen extends ConsumerWidget {
  const ClinicalComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_compliance_loading'), child: Semantics(label: 'clinical_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_compliance_screen'),
                    child: Column(
                      children: [
                        ClinicalComplianceHeaderSection(data: state.data),
                        ClinicalComplianceContentSummarySection(data: state.data),
                        ClinicalCompliancePrimaryContentSection(data: state.data),
                        ClinicalComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
