import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/specialist_dashboard_shell.dart';
import 'pediatric_dashboard_controller.dart';
import 'sections/pediatric_dashboard_header_section.dart';
import 'sections/pediatric_dashboard_summary_cards_section.dart';
import 'sections/pediatric_dashboard_chart_overview_section.dart';
import 'sections/pediatric_dashboard_recent_activity_section.dart';
import 'sections/pediatric_dashboard_quick_actions_section.dart';

class PediatricDashboardScreen extends ConsumerWidget {
  const PediatricDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pediatricDashboardControllerProvider);

    return PrimeSpecialistDashboardShell(
      title: 'Pediatric Clinical Dashboard',
      actions: [
        PrimeSpecialistDashboardShell.syncAction(
          () => ref.read(pediatricDashboardControllerProvider.notifier).syncData(),
        ),
      ],
      body: state.isLoading
          ? PrimeSpecialistDashboardShell.loading('pediatricdashboard_loading')
          : state.error != null
              ? PrimeSpecialistDashboardShell.error(state.error)
              : SingleChildScrollView(
                  key: const Key('pediatricdashboard_screen'),
                  child: Column(
                    children: [
                      PediatricDashboardHeaderSection(data: state.data),
                      PediatricDashboardSummaryCardsSection(data: state.data),
                      const PediatricDashboardChartOverviewSection(),
                      const PediatricDashboardRecentActivitySection(),
                      const PediatricDashboardQuickActionsSection(),
                    ],
                  ),
                ),
    );
  }
}
