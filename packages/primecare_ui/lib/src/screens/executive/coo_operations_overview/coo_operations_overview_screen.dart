import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coo_operations_overview_screen_controller.dart';
import 'sections/coo_operations_overview_header_section.dart';
import 'sections/coo_operations_overview_filter_bar_section.dart';
import 'sections/coo_operations_overview_data_table_section.dart';
import 'sections/coo_operations_overview_pagination_section.dart';
import 'sections/coo_operations_overview_action_bar_section.dart';


class CooOperationsOverviewScreen extends ConsumerWidget {
  const CooOperationsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coo_operations_overviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CooOperationsOverview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coo_operations_overviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coo_operations_overview_loading'), child: Semantics(label: 'coo_operations_overview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coo_operations_overview_screen'),
                    child: Column(
                      children: [
                        CooOperationsOverviewHeaderSection(data: state.data),
                        CooOperationsOverviewFilterBarSection(data: state.data),
                        CooOperationsOverviewDataTableSection(data: state.data),
                        CooOperationsOverviewPaginationSection(data: state.data),
                        CooOperationsOverviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
