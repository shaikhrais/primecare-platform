import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physician_dashboard_controller.dart';
import 'sections/physician_dashboard_header_section.dart';
import 'sections/physician_dashboard_summary_cards_section.dart';
import 'sections/physician_dashboard_chart_overview_section.dart';
import 'sections/physician_dashboard_recent_activity_section.dart';
import 'sections/physician_dashboard_quick_actions_section.dart';

class PhysicianDashboardScreen extends ConsumerWidget {
  const PhysicianDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physicianDashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Physician Clinical Dashboard'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(physicianDashboardControllerProvider.notifier).syncData(),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiciandashboard_loading'), child: CircularProgressIndicator())
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiciandashboard_screen'),
                    child: Column(
                      children: [
                        PhysicianDashboardHeaderSection(data: state.data),
                        PhysicianDashboardSummaryCardsSection(data: state.data),
                        const PhysicianDashboardChartOverviewSection(),
                        const PhysicianDashboardRecentActivitySection(),
                        const PhysicianDashboardQuickActionsSection(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
