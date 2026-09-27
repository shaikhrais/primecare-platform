import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinic_dashboard_screen_controller.dart';
import 'sections/clinic_dashboard_header_section.dart';
import 'sections/clinic_dashboard_summary_cards_section.dart';
import 'sections/clinic_dashboard_chart_overview_section.dart';
import 'sections/clinic_dashboard_recent_activity_section.dart';
import 'sections/clinic_dashboard_quick_actions_section.dart';


class ClinicDashboardScreen extends ConsumerWidget {
  const ClinicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinic_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinic_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinic_dashboard_loading'), child: Semantics(label: 'clinic_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinic_dashboard_screen'),
                    child: Column(
                      children: [
                        ClinicDashboardHeaderSection(data: state.data),
                        ClinicDashboardSummaryCardsSection(data: state.data),
                        ClinicDashboardChartOverviewSection(data: state.data),
                        ClinicDashboardRecentActivitySection(data: state.data),
                        ClinicDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
