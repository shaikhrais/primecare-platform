import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'office_compliance_screen_controller.dart';
import 'sections/office_compliance_header_section.dart';
import 'sections/office_compliance_content_summary_section.dart';
import 'sections/office_compliance_primary_content_section.dart';
import 'sections/office_compliance_action_bar_section.dart';


class OfficeComplianceScreen extends ConsumerWidget {
  const OfficeComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(office_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OfficeCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(office_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('office_compliance_loading'), child: Semantics(label: 'office_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('office_compliance_screen'),
                    child: Column(
                      children: [
                        OfficeComplianceHeaderSection(data: state.data),
                        OfficeComplianceContentSummarySection(data: state.data),
                        OfficeCompliancePrimaryContentSection(data: state.data),
                        OfficeComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
