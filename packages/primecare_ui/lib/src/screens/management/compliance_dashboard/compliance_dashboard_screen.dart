import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'compliance_dashboard_screen_controller.dart';
import 'sections/compliance_dashboard_header_section.dart';
import 'sections/compliance_dashboard_summary_cards_section.dart';
import 'sections/compliance_dashboard_chart_overview_section.dart';
import 'sections/compliance_dashboard_recent_activity_section.dart';
import 'sections/compliance_dashboard_quick_actions_section.dart';


class ComplianceDashboardScreen extends ConsumerWidget {
  const ComplianceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(compliance_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ComplianceDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(compliance_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('compliance_dashboard_loading'), child: Semantics(label: 'compliance_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('compliance_dashboard_screen'),
                    child: Column(
                      children: [
                        ComplianceDashboardHeaderSection(data: state.data),
                        ComplianceDashboardSummaryCardsSection(data: state.data),
                        ComplianceDashboardChartOverviewSection(data: state.data),
                        ComplianceDashboardRecentActivitySection(data: state.data),
                        ComplianceDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
