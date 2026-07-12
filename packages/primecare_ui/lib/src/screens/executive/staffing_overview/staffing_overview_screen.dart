import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'staffing_overview_screen_controller.dart';
import 'sections/staffing_overview_header_section.dart';
import 'sections/staffing_overview_filter_bar_section.dart';
import 'sections/staffing_overview_data_table_section.dart';
import 'sections/staffing_overview_pagination_section.dart';
import 'sections/staffing_overview_action_bar_section.dart';


class StaffingOverviewScreen extends ConsumerWidget {
  const StaffingOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(staffing_overviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('StaffingOverview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(staffing_overviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('staffing_overview_loading'), child: Semantics(label: 'staffing_overview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('staffing_overview_screen'),
                    child: Column(
                      children: [
                        StaffingOverviewHeaderSection(data: state.data),
                        StaffingOverviewFilterBarSection(data: state.data),
                        StaffingOverviewDataTableSection(data: state.data),
                        StaffingOverviewPaginationSection(data: state.data),
                        StaffingOverviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
