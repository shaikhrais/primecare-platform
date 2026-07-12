import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'ciso_dashboard_screen_controller.dart';
import 'sections/ciso_dashboard_header_section.dart';
import 'sections/ciso_dashboard_summary_cards_section.dart';
import 'sections/ciso_dashboard_chart_overview_section.dart';
import 'sections/ciso_dashboard_recent_activity_section.dart';
import 'sections/ciso_dashboard_quick_actions_section.dart';


class CisoDashboardScreen extends ConsumerWidget {
  const CisoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ciso_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CisoDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(ciso_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('ciso_dashboard_loading'), child: Semantics(label: 'ciso_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('ciso_dashboard_screen'),
                    child: Column(
                      children: [
                        CisoDashboardHeaderSection(data: state.data),
                        CisoDashboardSummaryCardsSection(data: state.data),
                        CisoDashboardChartOverviewSection(data: state.data),
                        CisoDashboardRecentActivitySection(data: state.data),
                        CisoDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
