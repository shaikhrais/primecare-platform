import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_compliance_screen_controller.dart';
import 'sections/rn_compliance_header_section.dart';
import 'sections/rn_compliance_content_summary_section.dart';
import 'sections/rn_compliance_primary_content_section.dart';
import 'sections/rn_compliance_action_bar_section.dart';


class RnComplianceScreen extends ConsumerWidget {
  const RnComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_compliance_loading'), child: Semantics(label: 'rn_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_compliance_screen'),
                    child: Column(
                      children: [
                        RnComplianceHeaderSection(data: state.data),
                        RnComplianceContentSummarySection(data: state.data),
                        RnCompliancePrimaryContentSection(data: state.data),
                        RnComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
