import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'business_development_compliance_screen_controller.dart';
import 'sections/business_development_compliance_header_section.dart';
import 'sections/business_development_compliance_content_summary_section.dart';
import 'sections/business_development_compliance_primary_content_section.dart';
import 'sections/business_development_compliance_action_bar_section.dart';


class BusinessDevelopmentComplianceScreen extends ConsumerWidget {
  const BusinessDevelopmentComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(business_development_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BusinessDevelopmentCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(business_development_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('business_development_compliance_loading'), child: Semantics(label: 'business_development_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('business_development_compliance_screen'),
                    child: Column(
                      children: [
                        BusinessDevelopmentComplianceHeaderSection(data: state.data),
                        BusinessDevelopmentComplianceContentSummarySection(data: state.data),
                        BusinessDevelopmentCompliancePrimaryContentSection(data: state.data),
                        BusinessDevelopmentComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
