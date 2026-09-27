import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'territory_expansion_manager_compliance_screen_controller.dart';
import 'sections/territory_expansion_manager_compliance_header_section.dart';
import 'sections/territory_expansion_manager_compliance_content_summary_section.dart';
import 'sections/territory_expansion_manager_compliance_primary_content_section.dart';
import 'sections/territory_expansion_manager_compliance_action_bar_section.dart';


class TerritoryExpansionManagerComplianceScreen extends ConsumerWidget {
  const TerritoryExpansionManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(territory_expansion_manager_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TerritoryExpansionManagerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(territory_expansion_manager_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('territory_expansion_manager_compliance_loading'), child: Semantics(label: 'territory_expansion_manager_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('territory_expansion_manager_compliance_screen'),
                    child: Column(
                      children: [
                        TerritoryExpansionManagerComplianceHeaderSection(data: state.data),
                        TerritoryExpansionManagerComplianceContentSummarySection(data: state.data),
                        TerritoryExpansionManagerCompliancePrimaryContentSection(data: state.data),
                        TerritoryExpansionManagerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
