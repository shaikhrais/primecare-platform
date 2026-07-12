import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'compliance_manager_dashboard_screen_controller.dart';
import 'sections/compliance_manager_dashboard_header_section.dart';
import 'sections/compliance_manager_dashboard_summary_cards_section.dart';
import 'sections/compliance_manager_dashboard_chart_overview_section.dart';
import 'sections/compliance_manager_dashboard_recent_activity_section.dart';
import 'sections/compliance_manager_dashboard_quick_actions_section.dart';


class ComplianceManagerDashboardScreen extends ConsumerWidget {
  const ComplianceManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(compliance_manager_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ComplianceManagerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(compliance_manager_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('compliance_manager_dashboard_loading'), child: Semantics(label: 'compliance_manager_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('compliance_manager_dashboard_screen'),
                    child: Column(
                      children: [
                        ComplianceManagerDashboardHeaderSection(data: state.data),
                        ComplianceManagerDashboardSummaryCardsSection(data: state.data),
                        ComplianceManagerDashboardChartOverviewSection(data: state.data),
                        ComplianceManagerDashboardRecentActivitySection(data: state.data),
                        ComplianceManagerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
