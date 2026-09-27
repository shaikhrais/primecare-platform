import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'legal_dashboard_screen_controller.dart';
import 'sections/legal_dashboard_header_section.dart';
import 'sections/legal_dashboard_summary_cards_section.dart';
import 'sections/legal_dashboard_chart_overview_section.dart';
import 'sections/legal_dashboard_recent_activity_section.dart';
import 'sections/legal_dashboard_quick_actions_section.dart';


class LegalDashboardScreen extends ConsumerWidget {
  const LegalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(legal_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LegalDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(legal_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('legal_dashboard_loading'), child: Semantics(label: 'legal_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('legal_dashboard_screen'),
                    child: Column(
                      children: [
                        LegalDashboardHeaderSection(data: state.data),
                        LegalDashboardSummaryCardsSection(data: state.data),
                        LegalDashboardChartOverviewSection(data: state.data),
                        LegalDashboardRecentActivitySection(data: state.data),
                        LegalDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
