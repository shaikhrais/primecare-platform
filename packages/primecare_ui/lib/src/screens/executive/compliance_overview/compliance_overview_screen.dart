import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'compliance_overview_screen_controller.dart';
import 'sections/compliance_overview_header_section.dart';
import 'sections/compliance_overview_filter_bar_section.dart';
import 'sections/compliance_overview_data_table_section.dart';
import 'sections/compliance_overview_pagination_section.dart';
import 'sections/compliance_overview_action_bar_section.dart';


class ComplianceOverviewScreen extends ConsumerWidget {
  const ComplianceOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(compliance_overviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ComplianceOverview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(compliance_overviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('compliance_overview_loading'), child: Semantics(label: 'compliance_overview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('compliance_overview_screen'),
                    child: Column(
                      children: [
                        ComplianceOverviewHeaderSection(data: state.data),
                        ComplianceOverviewFilterBarSection(data: state.data),
                        ComplianceOverviewDataTableSection(data: state.data),
                        ComplianceOverviewPaginationSection(data: state.data),
                        ComplianceOverviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
