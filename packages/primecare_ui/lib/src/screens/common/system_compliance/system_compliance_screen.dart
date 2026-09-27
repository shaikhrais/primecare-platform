import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'system_compliance_screen_controller.dart';
import 'sections/system_compliance_header_section.dart';
import 'sections/system_compliance_content_summary_section.dart';
import 'sections/system_compliance_primary_content_section.dart';
import 'sections/system_compliance_action_bar_section.dart';


class SystemComplianceScreen extends ConsumerWidget {
  const SystemComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(system_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SystemCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(system_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('system_compliance_loading'), child: Semantics(label: 'system_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('system_compliance_screen'),
                    child: Column(
                      children: [
                        SystemComplianceHeaderSection(data: state.data),
                        SystemComplianceContentSummarySection(data: state.data),
                        SystemCompliancePrimaryContentSection(data: state.data),
                        SystemComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
