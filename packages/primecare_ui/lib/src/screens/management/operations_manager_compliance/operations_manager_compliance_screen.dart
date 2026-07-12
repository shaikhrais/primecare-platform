import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'operations_manager_compliance_screen_controller.dart';
import 'sections/operations_manager_compliance_header_section.dart';
import 'sections/operations_manager_compliance_content_summary_section.dart';
import 'sections/operations_manager_compliance_primary_content_section.dart';
import 'sections/operations_manager_compliance_action_bar_section.dart';


class OperationsManagerComplianceScreen extends ConsumerWidget {
  const OperationsManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operations_manager_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OperationsManagerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(operations_manager_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('operations_manager_compliance_loading'), child: Semantics(label: 'operations_manager_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('operations_manager_compliance_screen'),
                    child: Column(
                      children: [
                        OperationsManagerComplianceHeaderSection(data: state.data),
                        OperationsManagerComplianceContentSummarySection(data: state.data),
                        OperationsManagerCompliancePrimaryContentSection(data: state.data),
                        OperationsManagerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
