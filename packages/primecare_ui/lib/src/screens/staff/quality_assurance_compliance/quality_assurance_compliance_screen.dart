import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'quality_assurance_compliance_screen_controller.dart';
import 'sections/quality_assurance_compliance_header_section.dart';
import 'sections/quality_assurance_compliance_content_summary_section.dart';
import 'sections/quality_assurance_compliance_primary_content_section.dart';
import 'sections/quality_assurance_compliance_action_bar_section.dart';


class QualityAssuranceComplianceScreen extends ConsumerWidget {
  const QualityAssuranceComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quality_assurance_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('QualityAssuranceCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(quality_assurance_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('quality_assurance_compliance_loading'), child: Semantics(label: 'quality_assurance_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('quality_assurance_compliance_screen'),
                    child: Column(
                      children: [
                        QualityAssuranceComplianceHeaderSection(data: state.data),
                        QualityAssuranceComplianceContentSummarySection(data: state.data),
                        QualityAssuranceCompliancePrimaryContentSection(data: state.data),
                        QualityAssuranceComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
