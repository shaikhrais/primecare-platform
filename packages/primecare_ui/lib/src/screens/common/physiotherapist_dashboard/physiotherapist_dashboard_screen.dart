import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../specialist_dashboard_shell.dart';
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

    return PrimeSpecialistDashboardShell(
      title: 'PhysiotherapistDashboard',
      actions: [
        PrimeSpecialistDashboardShell.syncAction(
          () => ref.read(physiotherapist_dashboardControllerProvider.notifier).syncData(),
          semanticLabel: 'sync-button',
        ),
      ],
      body: state.isLoading
          ? PrimeSpecialistDashboardShell.loading(
              'physiotherapist_dashboard_loading',
              semanticLabel: 'physiotherapist_dashboard_loading',
            )
          : state.error != null
              ? PrimeSpecialistDashboardShell.error(state.error)
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
    );
  }
}
