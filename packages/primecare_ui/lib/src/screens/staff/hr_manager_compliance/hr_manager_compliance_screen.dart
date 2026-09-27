import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_manager_compliance_screen_controller.dart';
import 'sections/hr_manager_compliance_header_section.dart';
import 'sections/hr_manager_compliance_content_summary_section.dart';
import 'sections/hr_manager_compliance_primary_content_section.dart';
import 'sections/hr_manager_compliance_action_bar_section.dart';


class HrManagerComplianceScreen extends ConsumerWidget {
  const HrManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_manager_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrManagerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_manager_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_manager_compliance_loading'), child: Semantics(label: 'hr_manager_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_manager_compliance_screen'),
                    child: Column(
                      children: [
                        HrManagerComplianceHeaderSection(data: state.data),
                        HrManagerComplianceContentSummarySection(data: state.data),
                        HrManagerCompliancePrimaryContentSection(data: state.data),
                        HrManagerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
