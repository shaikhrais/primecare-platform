import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'training_director_analytics_screen_controller.dart';
import 'sections/training_director_analytics_header_section.dart';
import 'sections/training_director_analytics_filter_bar_section.dart';
import 'sections/training_director_analytics_metrics_summary_section.dart';
import 'sections/training_director_analytics_chart_area_section.dart';
import 'sections/training_director_analytics_export_actions_section.dart';


class TrainingDirectorAnalyticsScreen extends ConsumerWidget {
  const TrainingDirectorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(training_director_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TrainingDirectorAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(training_director_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('training_director_analytics_loading'), child: Semantics(label: 'training_director_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('training_director_analytics_screen'),
                    child: Column(
                      children: [
                        TrainingDirectorAnalyticsHeaderSection(data: state.data),
                        TrainingDirectorAnalyticsFilterBarSection(data: state.data),
                        TrainingDirectorAnalyticsMetricsSummarySection(data: state.data),
                        TrainingDirectorAnalyticsChartAreaSection(data: state.data),
                        TrainingDirectorAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
