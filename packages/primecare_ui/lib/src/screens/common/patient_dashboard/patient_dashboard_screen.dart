import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_dashboard_screen_controller.dart';
import 'sections/patient_dashboard_header_section.dart';
import 'sections/patient_dashboard_summary_cards_section.dart';
import 'sections/patient_dashboard_chart_overview_section.dart';
import 'sections/patient_dashboard_recent_activity_section.dart';
import 'sections/patient_dashboard_quick_actions_section.dart';


class PatientDashboardScreen extends ConsumerWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_dashboard_loading'), child: Semantics(label: 'patient_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_dashboard_screen'),
                    child: Column(
                      children: [
                        PatientDashboardHeaderSection(data: state.data),
                        PatientDashboardSummaryCardsSection(data: state.data),
                        PatientDashboardChartOverviewSection(data: state.data),
                        PatientDashboardRecentActivitySection(data: state.data),
                        PatientDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
