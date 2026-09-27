import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'caregiver_dashboard_screen_controller.dart';
import 'sections/caregiver_dashboard_header_section.dart';
import 'sections/caregiver_dashboard_summary_cards_section.dart';
import 'sections/caregiver_dashboard_chart_overview_section.dart';
import 'sections/caregiver_dashboard_recent_activity_section.dart';
import 'sections/caregiver_dashboard_quick_actions_section.dart';


class CaregiverDashboardScreen extends ConsumerWidget {
  const CaregiverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caregiver_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CaregiverDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(caregiver_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('caregiver_dashboard_loading'), child: Semantics(label: 'caregiver_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('caregiver_dashboard_screen'),
                    child: Column(
                      children: [
                        CaregiverDashboardHeaderSection(data: state.data),
                        CaregiverDashboardSummaryCardsSection(data: state.data),
                        CaregiverDashboardChartOverviewSection(data: state.data),
                        CaregiverDashboardRecentActivitySection(data: state.data),
                        CaregiverDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
