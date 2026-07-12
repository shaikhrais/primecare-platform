import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'lpn_analytics_screen_controller.dart';
import 'sections/lpn_analytics_header_section.dart';
import 'sections/lpn_analytics_filter_bar_section.dart';
import 'sections/lpn_analytics_metrics_summary_section.dart';
import 'sections/lpn_analytics_chart_area_section.dart';
import 'sections/lpn_analytics_export_actions_section.dart';


class LicensedPracticalNurseLpnAnalyticsScreen extends ConsumerWidget {
  const LicensedPracticalNurseLpnAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lpn_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Licensed Practical Nurse (LPN) Analytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(lpn_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('lpn_analytics_loading'), child: Semantics(label: 'lpn_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('lpn_analytics_screen'),
                    child: Column(
                      children: [
                        LpnAnalyticsHeaderSection(data: state.data),
                        LpnAnalyticsFilterBarSection(data: state.data),
                        LpnAnalyticsMetricsSummarySection(data: state.data),
                        LpnAnalyticsChartAreaSection(data: state.data),
                        LpnAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef LicensedPracticalNurseLPNAnalyticsScreen = LicensedPracticalNurseLpnAnalyticsScreen;
