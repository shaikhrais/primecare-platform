import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'business_development_dashboard_screen_controller.dart';
import 'sections/business_development_dashboard_header_section.dart';
import 'sections/business_development_dashboard_summary_cards_section.dart';
import 'sections/business_development_dashboard_chart_overview_section.dart';
import 'sections/business_development_dashboard_recent_activity_section.dart';
import 'sections/business_development_dashboard_quick_actions_section.dart';


class BusinessDevelopmentDashboardScreen extends ConsumerWidget {
  const BusinessDevelopmentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(business_development_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BusinessDevelopmentDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(business_development_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('business_development_dashboard_loading'), child: Semantics(label: 'business_development_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('business_development_dashboard_screen'),
                    child: Column(
                      children: [
                        BusinessDevelopmentDashboardHeaderSection(data: state.data),
                        BusinessDevelopmentDashboardSummaryCardsSection(data: state.data),
                        BusinessDevelopmentDashboardChartOverviewSection(data: state.data),
                        BusinessDevelopmentDashboardRecentActivitySection(data: state.data),
                        BusinessDevelopmentDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
