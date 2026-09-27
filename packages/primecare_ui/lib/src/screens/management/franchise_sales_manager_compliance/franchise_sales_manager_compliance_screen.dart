import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_sales_manager_compliance_screen_controller.dart';
import 'sections/franchise_sales_manager_compliance_header_section.dart';
import 'sections/franchise_sales_manager_compliance_content_summary_section.dart';
import 'sections/franchise_sales_manager_compliance_primary_content_section.dart';
import 'sections/franchise_sales_manager_compliance_action_bar_section.dart';


class FranchiseSalesManagerComplianceScreen extends ConsumerWidget {
  const FranchiseSalesManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_sales_manager_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseSalesManagerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_sales_manager_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_sales_manager_compliance_loading'), child: Semantics(label: 'franchise_sales_manager_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_sales_manager_compliance_screen'),
                    child: Column(
                      children: [
                        FranchiseSalesManagerComplianceHeaderSection(data: state.data),
                        FranchiseSalesManagerComplianceContentSummarySection(data: state.data),
                        FranchiseSalesManagerCompliancePrimaryContentSection(data: state.data),
                        FranchiseSalesManagerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
