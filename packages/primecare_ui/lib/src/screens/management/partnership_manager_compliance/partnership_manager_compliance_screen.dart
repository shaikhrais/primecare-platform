import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'partnership_manager_compliance_screen_controller.dart';
import 'sections/partnership_manager_compliance_header_section.dart';
import 'sections/partnership_manager_compliance_content_summary_section.dart';
import 'sections/partnership_manager_compliance_primary_content_section.dart';
import 'sections/partnership_manager_compliance_action_bar_section.dart';


class PartnershipManagerComplianceScreen extends ConsumerWidget {
  const PartnershipManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(partnership_manager_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PartnershipManagerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(partnership_manager_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('partnership_manager_compliance_loading'), child: Semantics(label: 'partnership_manager_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('partnership_manager_compliance_screen'),
                    child: Column(
                      children: [
                        PartnershipManagerComplianceHeaderSection(data: state.data),
                        PartnershipManagerComplianceContentSummarySection(data: state.data),
                        PartnershipManagerCompliancePrimaryContentSection(data: state.data),
                        PartnershipManagerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
