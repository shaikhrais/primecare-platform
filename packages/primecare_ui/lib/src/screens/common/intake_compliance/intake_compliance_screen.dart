import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_compliance_screen_controller.dart';
import 'sections/intake_compliance_header_section.dart';
import 'sections/intake_compliance_content_summary_section.dart';
import 'sections/intake_compliance_primary_content_section.dart';
import 'sections/intake_compliance_action_bar_section.dart';


class IntakeComplianceScreen extends ConsumerWidget {
  const IntakeComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_compliance_loading'), child: Semantics(label: 'intake_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_compliance_screen'),
                    child: Column(
                      children: [
                        IntakeComplianceHeaderSection(data: state.data),
                        IntakeComplianceContentSummarySection(data: state.data),
                        IntakeCompliancePrimaryContentSection(data: state.data),
                        IntakeComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
