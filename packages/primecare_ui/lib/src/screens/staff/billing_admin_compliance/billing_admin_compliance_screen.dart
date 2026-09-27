import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'billing_admin_compliance_screen_controller.dart';
import 'sections/billing_admin_compliance_header_section.dart';
import 'sections/billing_admin_compliance_content_summary_section.dart';
import 'sections/billing_admin_compliance_primary_content_section.dart';
import 'sections/billing_admin_compliance_action_bar_section.dart';


class BillingAdminComplianceScreen extends ConsumerWidget {
  const BillingAdminComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billing_admin_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BillingAdminCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(billing_admin_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('billing_admin_compliance_loading'), child: Semantics(label: 'billing_admin_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('billing_admin_compliance_screen'),
                    child: Column(
                      children: [
                        BillingAdminComplianceHeaderSection(data: state.data),
                        BillingAdminComplianceContentSummarySection(data: state.data),
                        BillingAdminCompliancePrimaryContentSection(data: state.data),
                        BillingAdminComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
