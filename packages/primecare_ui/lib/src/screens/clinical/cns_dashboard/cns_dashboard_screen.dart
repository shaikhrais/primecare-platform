import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cns_dashboard_controller.dart';
import 'sections/cns_dashboard_header_section.dart';
import 'sections/cns_dashboard_summary_cards_section.dart';
import 'sections/cns_dashboard_chart_overview_section.dart';
import 'sections/cns_dashboard_recent_activity_section.dart';
import 'sections/cns_dashboard_quick_actions_section.dart';

class CnsDashboardScreen extends ConsumerWidget {
  const CnsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cnsDashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CNS Clinical Dashboard'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(cnsDashboardControllerProvider.notifier).syncData(),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cnsdashboard_loading'), child: CircularProgressIndicator())
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cnsdashboard_screen'),
                    child: Column(
                      children: [
                        CnsDashboardHeaderSection(data: state.data),
                        CnsDashboardSummaryCardsSection(data: state.data),
                        const CnsDashboardChartOverviewSection(),
                        const CnsDashboardRecentActivitySection(),
                        const CnsDashboardQuickActionsSection(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
