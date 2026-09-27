import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scrum_master_compliance_screen_controller.dart';
import 'sections/scrum_master_compliance_header_section.dart';
import 'sections/scrum_master_compliance_content_summary_section.dart';
import 'sections/scrum_master_compliance_primary_content_section.dart';
import 'sections/scrum_master_compliance_action_bar_section.dart';


class ScrumMasterComplianceScreen extends ConsumerWidget {
  const ScrumMasterComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scrum_master_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ScrumMasterCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scrum_master_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scrum_master_compliance_loading'), child: Semantics(label: 'scrum_master_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scrum_master_compliance_screen'),
                    child: Column(
                      children: [
                        ScrumMasterComplianceHeaderSection(data: state.data),
                        ScrumMasterComplianceContentSummarySection(data: state.data),
                        ScrumMasterCompliancePrimaryContentSection(data: state.data),
                        ScrumMasterComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
