import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_director_compliance_screen_controller.dart';
import 'sections/clinical_director_compliance_header_section.dart';
import 'sections/clinical_director_compliance_content_summary_section.dart';
import 'sections/clinical_director_compliance_primary_content_section.dart';
import 'sections/clinical_director_compliance_action_bar_section.dart';


class ClinicalDirectorComplianceScreen extends ConsumerWidget {
  const ClinicalDirectorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_director_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalDirectorCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_director_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_director_compliance_loading'), child: Semantics(label: 'clinical_director_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_director_compliance_screen'),
                    child: Column(
                      children: [
                        ClinicalDirectorComplianceHeaderSection(data: state.data),
                        ClinicalDirectorComplianceContentSummarySection(data: state.data),
                        ClinicalDirectorCompliancePrimaryContentSection(data: state.data),
                        ClinicalDirectorComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
