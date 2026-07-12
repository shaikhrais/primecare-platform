import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'head_of_bus_dev_compliance_screen_controller.dart';
import 'sections/head_of_bus_dev_compliance_header_section.dart';
import 'sections/head_of_bus_dev_compliance_content_summary_section.dart';
import 'sections/head_of_bus_dev_compliance_primary_content_section.dart';
import 'sections/head_of_bus_dev_compliance_action_bar_section.dart';


class HeadOfBusDevComplianceScreen extends ConsumerWidget {
  const HeadOfBusDevComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(head_of_bus_dev_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HeadOfBusDevCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(head_of_bus_dev_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('head_of_bus_dev_compliance_loading'), child: Semantics(label: 'head_of_bus_dev_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('head_of_bus_dev_compliance_screen'),
                    child: Column(
                      children: [
                        HeadOfBusDevComplianceHeaderSection(data: state.data),
                        HeadOfBusDevComplianceContentSummarySection(data: state.data),
                        HeadOfBusDevCompliancePrimaryContentSection(data: state.data),
                        HeadOfBusDevComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
