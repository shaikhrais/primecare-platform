import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'testing_overview_screen_controller.dart';
import 'sections/testing_overview_header_section.dart';
import 'sections/testing_overview_filter_bar_section.dart';
import 'sections/testing_overview_data_table_section.dart';
import 'sections/testing_overview_pagination_section.dart';
import 'sections/testing_overview_action_bar_section.dart';


class TestingOverviewScreen extends ConsumerWidget {
  const TestingOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(testing_overviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TestingOverview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(testing_overviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('testing_overview_loading'), child: Semantics(label: 'testing_overview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('testing_overview_screen'),
                    child: Column(
                      children: [
                        TestingOverviewHeaderSection(data: state.data),
                        TestingOverviewFilterBarSection(data: state.data),
                        TestingOverviewDataTableSection(data: state.data),
                        TestingOverviewPaginationSection(data: state.data),
                        TestingOverviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
