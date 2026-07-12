import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_director_dashboard_screen_controller.dart';
import 'sections/hr_director_dashboard_header_section.dart';
import 'sections/hr_director_dashboard_summary_cards_section.dart';
import 'sections/hr_director_dashboard_chart_overview_section.dart';
import 'sections/hr_director_dashboard_recent_activity_section.dart';
import 'sections/hr_director_dashboard_quick_actions_section.dart';


class HrDirectorDashboardScreen extends ConsumerWidget {
  const HrDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_director_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrDirectorDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_director_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_director_dashboard_loading'), child: Semantics(label: 'hr_director_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_director_dashboard_screen'),
                    child: Column(
                      children: [
                        HrDirectorDashboardHeaderSection(data: state.data),
                        HrDirectorDashboardSummaryCardsSection(data: state.data),
                        HrDirectorDashboardChartOverviewSection(data: state.data),
                        HrDirectorDashboardRecentActivitySection(data: state.data),
                        HrDirectorDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
