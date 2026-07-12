import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'employee_dashboard_screen_controller.dart';
import 'sections/employee_dashboard_header_section.dart';
import 'sections/employee_dashboard_summary_cards_section.dart';
import 'sections/employee_dashboard_chart_overview_section.dart';
import 'sections/employee_dashboard_recent_activity_section.dart';
import 'sections/employee_dashboard_quick_actions_section.dart';


class EmployeeDashboardScreen extends ConsumerWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(employee_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('EmployeeDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(employee_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('employee_dashboard_loading'), child: Semantics(label: 'employee_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('employee_dashboard_screen'),
                    child: Column(
                      children: [
                        EmployeeDashboardHeaderSection(data: state.data),
                        EmployeeDashboardSummaryCardsSection(data: state.data),
                        EmployeeDashboardChartOverviewSection(data: state.data),
                        EmployeeDashboardRecentActivitySection(data: state.data),
                        EmployeeDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
