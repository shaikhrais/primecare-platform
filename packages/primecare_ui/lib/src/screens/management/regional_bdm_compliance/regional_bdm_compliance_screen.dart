import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'regional_bdm_compliance_screen_controller.dart';
import 'sections/regional_bdm_compliance_header_section.dart';
import 'sections/regional_bdm_compliance_content_summary_section.dart';
import 'sections/regional_bdm_compliance_primary_content_section.dart';
import 'sections/regional_bdm_compliance_action_bar_section.dart';


class RegionalBdmComplianceScreen extends ConsumerWidget {
  const RegionalBdmComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regional_bdm_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RegionalBdmCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(regional_bdm_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('regional_bdm_compliance_loading'), child: Semantics(label: 'regional_bdm_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('regional_bdm_compliance_screen'),
                    child: Column(
                      children: [
                        RegionalBdmComplianceHeaderSection(data: state.data),
                        RegionalBdmComplianceContentSummarySection(data: state.data),
                        RegionalBdmCompliancePrimaryContentSection(data: state.data),
                        RegionalBdmComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
