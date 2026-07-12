import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'np_dashboard_controller.dart';
import 'sections/np_dashboard_header_section.dart';
import 'sections/np_dashboard_summary_cards_section.dart';
import 'sections/np_dashboard_chart_overview_section.dart';
import 'sections/np_dashboard_recent_activity_section.dart';
import 'sections/np_dashboard_quick_actions_section.dart';

class NpDashboardScreen extends ConsumerWidget {
  const NpDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(npDashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Nurse Practitioner Dashboard'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(npDashboardControllerProvider.notifier).syncData(),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('npdashboard_loading'), child: CircularProgressIndicator())
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('npdashboard_screen'),
                    child: Column(
                      children: [
                        NpDashboardHeaderSection(data: state.data),
                        NpDashboardSummaryCardsSection(data: state.data),
                        const NpDashboardChartOverviewSection(),
                        const NpDashboardRecentActivitySection(),
                        const NpDashboardQuickActionsSection(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
