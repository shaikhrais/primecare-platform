import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'support_compliance_screen_controller.dart';
import 'sections/support_compliance_header_section.dart';
import 'sections/support_compliance_content_summary_section.dart';
import 'sections/support_compliance_primary_content_section.dart';
import 'sections/support_compliance_action_bar_section.dart';


class SupportComplianceScreen extends ConsumerWidget {
  const SupportComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(support_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SupportCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(support_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('support_compliance_loading'), child: Semantics(label: 'support_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('support_compliance_screen'),
                    child: Column(
                      children: [
                        SupportComplianceHeaderSection(data: state.data),
                        SupportComplianceContentSummarySection(data: state.data),
                        SupportCompliancePrimaryContentSection(data: state.data),
                        SupportComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
