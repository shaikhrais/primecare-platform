import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_compliance_screen_controller.dart';
import 'sections/physiotherapist_compliance_header_section.dart';
import 'sections/physiotherapist_compliance_content_summary_section.dart';
import 'sections/physiotherapist_compliance_primary_content_section.dart';
import 'sections/physiotherapist_compliance_action_bar_section.dart';


class PhysiotherapistComplianceScreen extends ConsumerWidget {
  const PhysiotherapistComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_compliance_loading'), child: Semantics(label: 'physiotherapist_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_compliance_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistComplianceHeaderSection(data: state.data),
                        PhysiotherapistComplianceContentSummarySection(data: state.data),
                        PhysiotherapistCompliancePrimaryContentSection(data: state.data),
                        PhysiotherapistComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
