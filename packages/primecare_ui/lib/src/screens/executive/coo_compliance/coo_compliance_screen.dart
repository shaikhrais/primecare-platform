import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coo_compliance_screen_controller.dart';
import 'sections/coo_compliance_header_section.dart';
import 'sections/coo_compliance_filter_bar_section.dart';
import 'sections/coo_compliance_data_table_section.dart';
import 'sections/coo_compliance_pagination_section.dart';
import 'sections/coo_compliance_action_bar_section.dart';


class CooComplianceScreen extends ConsumerWidget {
  const CooComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coo_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CooCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coo_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coo_compliance_loading'), child: Semantics(label: 'coo_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coo_compliance_screen'),
                    child: Column(
                      children: [
                        CooComplianceHeaderSection(data: state.data),
                        CooComplianceFilterBarSection(data: state.data),
                        CooComplianceDataTableSection(data: state.data),
                        CooCompliancePaginationSection(data: state.data),
                        CooComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
