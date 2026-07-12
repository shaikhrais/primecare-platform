import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_dashboard_controller.dart';
import 'sections/rmt_dashboard_header_section.dart';
import 'sections/rmt_dashboard_summary_cards_section.dart';
import 'sections/rmt_dashboard_chart_overview_section.dart';
import 'sections/rmt_dashboard_recent_activity_section.dart';
import 'sections/rmt_dashboard_quick_actions_section.dart';

class RmtDashboardScreen extends ConsumerWidget {
  const RmtDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmtDashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RMT Clinical Dashboard'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(rmtDashboardControllerProvider.notifier).syncData(),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmtdashboard_loading'), child: CircularProgressIndicator())
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmtdashboard_screen'),
                    child: Column(
                      children: [
                        RmtDashboardHeaderSection(data: state.data),
                        RmtDashboardSummaryCardsSection(data: state.data),
                        const RmtDashboardChartOverviewSection(),
                        const RmtDashboardRecentActivitySection(),
                        const RmtDashboardQuickActionsSection(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
