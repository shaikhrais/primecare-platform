import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'customer_support_compliance_screen_controller.dart';
import 'sections/customer_support_compliance_header_section.dart';
import 'sections/customer_support_compliance_content_summary_section.dart';
import 'sections/customer_support_compliance_primary_content_section.dart';
import 'sections/customer_support_compliance_action_bar_section.dart';


class CustomerSupportComplianceScreen extends ConsumerWidget {
  const CustomerSupportComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customer_support_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CustomerSupportCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(customer_support_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('customer_support_compliance_loading'), child: Semantics(label: 'customer_support_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('customer_support_compliance_screen'),
                    child: Column(
                      children: [
                        CustomerSupportComplianceHeaderSection(data: state.data),
                        CustomerSupportComplianceContentSummarySection(data: state.data),
                        CustomerSupportCompliancePrimaryContentSection(data: state.data),
                        CustomerSupportComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
