import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'system_verification_dashboard_screen_controller.dart';
import 'sections/system_verification_dashboard_header_section.dart';
import 'sections/system_verification_dashboard_summary_cards_section.dart';
import 'sections/system_verification_dashboard_chart_overview_section.dart';
import 'sections/system_verification_dashboard_recent_activity_section.dart';
import 'sections/system_verification_dashboard_quick_actions_section.dart';


class SystemVerificationDashboardScreen extends ConsumerWidget {
  const SystemVerificationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(system_verification_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SystemVerificationDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(system_verification_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('system_verification_dashboard_loading'), child: Semantics(label: 'system_verification_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('system_verification_dashboard_screen'),
                    child: Column(
                      children: [
                        SystemVerificationDashboardHeaderSection(data: state.data),
                        SystemVerificationDashboardSummaryCardsSection(data: state.data),
                        SystemVerificationDashboardChartOverviewSection(data: state.data),
                        SystemVerificationDashboardRecentActivitySection(data: state.data),
                        SystemVerificationDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
