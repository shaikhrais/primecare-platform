import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'quality_assurance_dashboard_screen_controller.dart';
import 'sections/quality_assurance_dashboard_header_section.dart';
import 'sections/quality_assurance_dashboard_summary_cards_section.dart';
import 'sections/quality_assurance_dashboard_chart_overview_section.dart';
import 'sections/quality_assurance_dashboard_recent_activity_section.dart';
import 'sections/quality_assurance_dashboard_quick_actions_section.dart';


class QualityAssuranceDashboardScreen extends ConsumerWidget {
  const QualityAssuranceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quality_assurance_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('QualityAssuranceDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(quality_assurance_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('quality_assurance_dashboard_loading'), child: Semantics(label: 'quality_assurance_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('quality_assurance_dashboard_screen'),
                    child: Column(
                      children: [
                        QualityAssuranceDashboardHeaderSection(data: state.data),
                        QualityAssuranceDashboardSummaryCardsSection(data: state.data),
                        QualityAssuranceDashboardChartOverviewSection(data: state.data),
                        QualityAssuranceDashboardRecentActivitySection(data: state.data),
                        QualityAssuranceDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
