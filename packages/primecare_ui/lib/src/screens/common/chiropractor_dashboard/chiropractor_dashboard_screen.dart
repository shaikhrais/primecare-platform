import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_dashboard_screen_controller.dart';
import 'sections/chiropractor_dashboard_header_section.dart';
import 'sections/chiropractor_dashboard_summary_cards_section.dart';
import 'sections/chiropractor_dashboard_chart_overview_section.dart';
import 'sections/chiropractor_dashboard_recent_activity_section.dart';
import 'sections/chiropractor_dashboard_quick_actions_section.dart';


class ChiropractorDashboardScreen extends ConsumerWidget {
  const ChiropractorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_dashboard_loading'), child: Semantics(label: 'chiropractor_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_dashboard_screen'),
                    child: Column(
                      children: [
                        ChiropractorDashboardHeaderSection(data: state.data),
                        ChiropractorDashboardSummaryCardsSection(data: state.data),
                        ChiropractorDashboardChartOverviewSection(data: state.data),
                        ChiropractorDashboardRecentActivitySection(data: state.data),
                        ChiropractorDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
