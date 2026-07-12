import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'support_dashboard_screen_controller.dart';
import 'sections/support_dashboard_header_section.dart';
import 'sections/support_dashboard_summary_cards_section.dart';
import 'sections/support_dashboard_chart_overview_section.dart';
import 'sections/support_dashboard_recent_activity_section.dart';
import 'sections/support_dashboard_quick_actions_section.dart';


class SupportDashboardScreen extends ConsumerWidget {
  const SupportDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(support_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SupportDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(support_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('support_dashboard_loading'), child: Semantics(label: 'support_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('support_dashboard_screen'),
                    child: Column(
                      children: [
                        SupportDashboardHeaderSection(data: state.data),
                        SupportDashboardSummaryCardsSection(data: state.data),
                        SupportDashboardChartOverviewSection(data: state.data),
                        SupportDashboardRecentActivitySection(data: state.data),
                        SupportDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
