import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_compliance_screen_controller.dart';
import 'sections/cfo_compliance_header_section.dart';
import 'sections/cfo_compliance_content_summary_section.dart';
import 'sections/cfo_compliance_primary_content_section.dart';
import 'sections/cfo_compliance_action_bar_section.dart';


class CfoComplianceScreen extends ConsumerWidget {
  const CfoComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_compliance_loading'), child: Semantics(label: 'cfo_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_compliance_screen'),
                    child: Column(
                      children: [
                        CfoComplianceHeaderSection(data: state.data),
                        CfoComplianceContentSummarySection(data: state.data),
                        CfoCompliancePrimaryContentSection(data: state.data),
                        CfoComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
