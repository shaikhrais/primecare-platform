import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'family_overview_screen_controller.dart';
import 'sections/family_overview_header_section.dart';
import 'sections/family_overview_filter_bar_section.dart';
import 'sections/family_overview_data_table_section.dart';
import 'sections/family_overview_pagination_section.dart';
import 'sections/family_overview_action_bar_section.dart';


class FamilyOverviewScreen extends ConsumerWidget {
  const FamilyOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(family_overviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FamilyOverview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(family_overviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('family_overview_loading'), child: Semantics(label: 'family_overview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('family_overview_screen'),
                    child: Column(
                      children: [
                        FamilyOverviewHeaderSection(data: state.data),
                        FamilyOverviewFilterBarSection(data: state.data),
                        FamilyOverviewDataTableSection(data: state.data),
                        FamilyOverviewPaginationSection(data: state.data),
                        FamilyOverviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
