import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'owner_analytics_screen_controller.dart';
import 'sections/owner_analytics_header_section.dart';
import 'sections/owner_analytics_filter_bar_section.dart';
import 'sections/owner_analytics_metrics_summary_section.dart';
import 'sections/owner_analytics_chart_area_section.dart';
import 'sections/owner_analytics_export_actions_section.dart';


class OwnerAnalyticsScreen extends ConsumerWidget {
  const OwnerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(owner_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OwnerAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(owner_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('owner_analytics_loading'), child: Semantics(label: 'owner_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('owner_analytics_screen'),
                    child: Column(
                      children: [
                        OwnerAnalyticsHeaderSection(data: state.data),
                        OwnerAnalyticsFilterBarSection(data: state.data),
                        OwnerAnalyticsMetricsSummarySection(data: state.data),
                        OwnerAnalyticsChartAreaSection(data: state.data),
                        OwnerAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
