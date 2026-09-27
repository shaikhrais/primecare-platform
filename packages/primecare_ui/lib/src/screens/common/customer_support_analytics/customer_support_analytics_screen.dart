import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'customer_support_analytics_screen_controller.dart';
import 'sections/customer_support_analytics_header_section.dart';
import 'sections/customer_support_analytics_filter_bar_section.dart';
import 'sections/customer_support_analytics_metrics_summary_section.dart';
import 'sections/customer_support_analytics_chart_area_section.dart';
import 'sections/customer_support_analytics_export_actions_section.dart';


class CustomerSupportAnalyticsScreen extends ConsumerWidget {
  const CustomerSupportAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customer_support_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CustomerSupportAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(customer_support_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('customer_support_analytics_loading'), child: Semantics(label: 'customer_support_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('customer_support_analytics_screen'),
                    child: Column(
                      children: [
                        CustomerSupportAnalyticsHeaderSection(data: state.data),
                        CustomerSupportAnalyticsFilterBarSection(data: state.data),
                        CustomerSupportAnalyticsMetricsSummarySection(data: state.data),
                        CustomerSupportAnalyticsChartAreaSection(data: state.data),
                        CustomerSupportAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
