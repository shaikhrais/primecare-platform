import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_overview_screen_controller.dart';
import 'sections/franchise_overview_header_section.dart';
import 'sections/franchise_overview_filter_bar_section.dart';
import 'sections/franchise_overview_data_table_section.dart';
import 'sections/franchise_overview_pagination_section.dart';
import 'sections/franchise_overview_action_bar_section.dart';


class FranchiseOverviewScreen extends ConsumerWidget {
  const FranchiseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_overviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseOverview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_overviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_overview_loading'), child: Semantics(label: 'franchise_overview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_overview_screen'),
                    child: Column(
                      children: [
                        FranchiseOverviewHeaderSection(data: state.data),
                        FranchiseOverviewFilterBarSection(data: state.data),
                        FranchiseOverviewDataTableSection(data: state.data),
                        FranchiseOverviewPaginationSection(data: state.data),
                        FranchiseOverviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
