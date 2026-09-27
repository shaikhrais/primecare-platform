import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cto_compliance_screen_controller.dart';
import 'sections/cto_compliance_header_section.dart';
import 'sections/cto_compliance_content_summary_section.dart';
import 'sections/cto_compliance_primary_content_section.dart';
import 'sections/cto_compliance_action_bar_section.dart';


class CtoComplianceScreen extends ConsumerWidget {
  const CtoComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cto_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CtoCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cto_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cto_compliance_loading'), child: Semantics(label: 'cto_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cto_compliance_screen'),
                    child: Column(
                      children: [
                        CtoComplianceHeaderSection(data: state.data),
                        CtoComplianceContentSummarySection(data: state.data),
                        CtoCompliancePrimaryContentSection(data: state.data),
                        CtoComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
