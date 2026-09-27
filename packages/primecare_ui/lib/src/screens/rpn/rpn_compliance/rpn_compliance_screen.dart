import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_compliance_screen_controller.dart';
import 'sections/rpn_compliance_header_section.dart';
import 'sections/rpn_compliance_content_summary_section.dart';
import 'sections/rpn_compliance_primary_content_section.dart';
import 'sections/rpn_compliance_action_bar_section.dart';


class RpnComplianceScreen extends ConsumerWidget {
  const RpnComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_compliance_loading'), child: Semantics(label: 'rpn_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_compliance_screen'),
                    child: Column(
                      children: [
                        RpnComplianceHeaderSection(data: state.data),
                        RpnComplianceContentSummarySection(data: state.data),
                        RpnCompliancePrimaryContentSection(data: state.data),
                        RpnComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
