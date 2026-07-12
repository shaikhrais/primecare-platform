import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'guest_analytics_screen_controller.dart';
import 'sections/guest_analytics_header_section.dart';
import 'sections/guest_analytics_filter_bar_section.dart';
import 'sections/guest_analytics_metrics_summary_section.dart';
import 'sections/guest_analytics_chart_area_section.dart';
import 'sections/guest_analytics_export_actions_section.dart';


class GuestAnalyticsScreen extends ConsumerWidget {
  const GuestAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guest_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('GuestAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(guest_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('guest_analytics_loading'), child: Semantics(label: 'guest_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('guest_analytics_screen'),
                    child: Column(
                      children: [
                        GuestAnalyticsHeaderSection(data: state.data),
                        GuestAnalyticsFilterBarSection(data: state.data),
                        GuestAnalyticsMetricsSummarySection(data: state.data),
                        GuestAnalyticsChartAreaSection(data: state.data),
                        GuestAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
