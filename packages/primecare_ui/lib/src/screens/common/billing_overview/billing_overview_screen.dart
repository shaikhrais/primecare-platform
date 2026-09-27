import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'billing_overview_screen_controller.dart';
import 'sections/billing_overview_header_section.dart';
import 'sections/billing_overview_filter_bar_section.dart';
import 'sections/billing_overview_data_table_section.dart';
import 'sections/billing_overview_pagination_section.dart';
import 'sections/billing_overview_action_bar_section.dart';


class BillingOverviewScreen extends ConsumerWidget {
  const BillingOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billing_overviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BillingOverview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(billing_overviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('billing_overview_loading'), child: Semantics(label: 'billing_overview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('billing_overview_screen'),
                    child: Column(
                      children: [
                        BillingOverviewHeaderSection(data: state.data),
                        BillingOverviewFilterBarSection(data: state.data),
                        BillingOverviewDataTableSection(data: state.data),
                        BillingOverviewPaginationSection(data: state.data),
                        BillingOverviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
