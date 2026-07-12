import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'local_marketing_manager_compliance_screen_controller.dart';
import 'sections/local_marketing_manager_compliance_header_section.dart';
import 'sections/local_marketing_manager_compliance_content_summary_section.dart';
import 'sections/local_marketing_manager_compliance_primary_content_section.dart';
import 'sections/local_marketing_manager_compliance_action_bar_section.dart';


class LocalMarketingManagerComplianceScreen extends ConsumerWidget {
  const LocalMarketingManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(local_marketing_manager_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LocalMarketingManagerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(local_marketing_manager_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('local_marketing_manager_compliance_loading'), child: Semantics(label: 'local_marketing_manager_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('local_marketing_manager_compliance_screen'),
                    child: Column(
                      children: [
                        LocalMarketingManagerComplianceHeaderSection(data: state.data),
                        LocalMarketingManagerComplianceContentSummarySection(data: state.data),
                        LocalMarketingManagerCompliancePrimaryContentSection(data: state.data),
                        LocalMarketingManagerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
