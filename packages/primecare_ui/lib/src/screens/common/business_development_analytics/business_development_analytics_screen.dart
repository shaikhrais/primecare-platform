import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'business_development_analytics_screen_controller.dart';
import 'sections/business_development_analytics_header_section.dart';
import 'sections/business_development_analytics_filter_bar_section.dart';
import 'sections/business_development_analytics_metrics_summary_section.dart';
import 'sections/business_development_analytics_chart_area_section.dart';
import 'sections/business_development_analytics_export_actions_section.dart';


class BusinessDevelopmentAnalyticsScreen extends ConsumerWidget {
  const BusinessDevelopmentAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(business_development_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BusinessDevelopmentAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(business_development_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('business_development_analytics_loading'), child: Semantics(label: 'business_development_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('business_development_analytics_screen'),
                    child: Column(
                      children: [
                        BusinessDevelopmentAnalyticsHeaderSection(data: state.data),
                        BusinessDevelopmentAnalyticsFilterBarSection(data: state.data),
                        BusinessDevelopmentAnalyticsMetricsSummarySection(data: state.data),
                        BusinessDevelopmentAnalyticsChartAreaSection(data: state.data),
                        BusinessDevelopmentAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
