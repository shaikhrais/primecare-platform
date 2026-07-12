import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'social_worker_dashboard_screen_controller.dart';
import 'sections/social_worker_dashboard_header_section.dart';
import 'sections/social_worker_dashboard_summary_cards_section.dart';
import 'sections/social_worker_dashboard_chart_overview_section.dart';
import 'sections/social_worker_dashboard_recent_activity_section.dart';
import 'sections/social_worker_dashboard_quick_actions_section.dart';


class SocialWorkerDashboardScreen extends ConsumerWidget {
  const SocialWorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(social_worker_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SocialWorkerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(social_worker_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('social_worker_dashboard_loading'), child: Semantics(label: 'social_worker_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('social_worker_dashboard_screen'),
                    child: Column(
                      children: [
                        SocialWorkerDashboardHeaderSection(data: state.data),
                        SocialWorkerDashboardSummaryCardsSection(data: state.data),
                        SocialWorkerDashboardChartOverviewSection(data: state.data),
                        SocialWorkerDashboardRecentActivitySection(data: state.data),
                        SocialWorkerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
