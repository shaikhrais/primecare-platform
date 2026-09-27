import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'family_member_dashboard_screen_controller.dart';
import 'sections/family_member_dashboard_header_section.dart';
import 'sections/family_member_dashboard_summary_cards_section.dart';
import 'sections/family_member_dashboard_chart_overview_section.dart';
import 'sections/family_member_dashboard_recent_activity_section.dart';
import 'sections/family_member_dashboard_quick_actions_section.dart';


class FamilyMemberDashboardScreen extends ConsumerWidget {
  const FamilyMemberDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(family_member_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FamilyMemberDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(family_member_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('family_member_dashboard_loading'), child: Semantics(label: 'family_member_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('family_member_dashboard_screen'),
                    child: Column(
                      children: [
                        FamilyMemberDashboardHeaderSection(data: state.data),
                        FamilyMemberDashboardSummaryCardsSection(data: state.data),
                        FamilyMemberDashboardChartOverviewSection(data: state.data),
                        FamilyMemberDashboardRecentActivitySection(data: state.data),
                        FamilyMemberDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
