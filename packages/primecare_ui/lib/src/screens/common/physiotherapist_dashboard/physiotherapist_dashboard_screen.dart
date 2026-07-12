import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_dashboard_screen_controller.dart';
import 'sections/physiotherapist_dashboard_header_section.dart';
import 'sections/physiotherapist_dashboard_summary_cards_section.dart';
import 'sections/physiotherapist_dashboard_chart_overview_section.dart';
import 'sections/physiotherapist_dashboard_recent_activity_section.dart';
import 'sections/physiotherapist_dashboard_quick_actions_section.dart';


class PhysiotherapistDashboardScreen extends ConsumerWidget {
  const PhysiotherapistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_dashboard_loading'), child: Semantics(label: 'physiotherapist_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_dashboard_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistDashboardHeaderSection(data: state.data),
                        PhysiotherapistDashboardSummaryCardsSection(data: state.data),
                        PhysiotherapistDashboardChartOverviewSection(data: state.data),
                        PhysiotherapistDashboardRecentActivitySection(data: state.data),
                        PhysiotherapistDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
