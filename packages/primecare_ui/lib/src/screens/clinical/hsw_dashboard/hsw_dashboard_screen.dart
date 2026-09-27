import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hsw_dashboard_controller.dart';
import 'sections/hsw_dashboard_header_section.dart';
import 'sections/hsw_dashboard_summary_cards_section.dart';
import 'sections/hsw_dashboard_chart_overview_section.dart';
import 'sections/hsw_dashboard_recent_activity_section.dart';
import 'sections/hsw_dashboard_quick_actions_section.dart';

class HswDashboardScreen extends ConsumerWidget {
  const HswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hswDashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HSW Clinical Dashboard'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(hswDashboardControllerProvider.notifier).syncData(),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hswdashboard_loading'), child: CircularProgressIndicator())
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hswdashboard_screen'),
                    child: Column(
                      children: [
                        HswDashboardHeaderSection(data: state.data),
                        HswDashboardSummaryCardsSection(data: state.data),
                        const HswDashboardChartOverviewSection(),
                        const HswDashboardRecentActivitySection(),
                        const HswDashboardQuickActionsSection(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
