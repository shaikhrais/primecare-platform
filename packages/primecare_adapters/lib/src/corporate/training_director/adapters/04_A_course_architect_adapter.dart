import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final courseArchitectAdapterProvider =
    FutureProvider<Result<CourseArchitectViewModel>>((ref) async {
      const cacheKey = 'course_architect_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);
      final modulesResult = await ref.watch(trainingModulesProvider.future);

      return modulesResult.fold(
        (modulesList) {
          final viewModel = CourseArchitectViewModel(
            availableModules: modulesList
                .map((e) => TrainingModuleModel.fromJson(e))
                .toList(),
            metrics: _enhanceCurriculumMetrics(),
            insights: _generateCurriculumInsights(),
          );

          // Persist snapshot for resilience
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

          telemetry.passGate(
            ExecutionGateCategory.compliance,
            'Course Architect Hydrated with curriculum intelligence',
            metadata: {'module_count': viewModel.availableModules.length},
          );

          return Result.success(viewModel);
        },
        (error) {
          telemetry.failGate(
            ExecutionGateCategory.compliance,
            'Course Architect Module Load Failed',
            error: error,
          );

          // Resilience Fallback
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Result.success(CourseArchitectViewModel.fromJson(snapshot));
          }

          return Result.failure(error);
        },
      );
    });

DashboardMetrics _enhanceCurriculumMetrics() {
  return DashboardMetrics(
    kpis: [
      const KpiMetric(
        title: 'Avg. Pass Rate',
        value: '94%',
        trend: '+2%',
        status: 'positive',
      ),
      const KpiMetric(
        title: 'Content Freshness',
        value: '98%',
        trend: 'Stable',
        status: 'positive',
      ),
      const KpiMetric(
        title: 'Engagement',
        value: '4.8/5',
        trend: '+0.2',
        status: 'positive',
      ),
      const KpiMetric(
        title: 'Certifications',
        value: '1,240',
        trend: '+15%',
        status: 'positive',
      ),
    ],
    charts: [
      AnalyticsChart(
        id: 'module_performance',
        title: 'Module Completion Velocity',
        type: ChartType.line,
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
        datasets: [
          AnalyticsChartDataset(
            label: 'Completions',
            data: [450, 520, 610, 580, 720],
          ),
        ],
      ),
    ],
    recentActivity: [],
  );
}

List<IntelligenceInsight> _generateCurriculumInsights() {
  return [
    IntelligenceInsight(
      id: 'curr_insight_1',
      title: 'Module Optimization',
      summary:
          'Module "Safety v2" has a 12% drop-off rate at Slide 15. Content may be too dense.',
      type: InsightType.optimization,
      impact: InsightImpact.warning,
      recommendation: 'Break Slide 15 into three micro-learning segments.',
    ),
    IntelligenceInsight(
      id: 'curr_insight_2',
      title: 'High Engagement Trend',
      summary:
          'Interactive video assessments are yielding 20% higher retention scores.',
      type: InsightType.growth,
      impact: InsightImpact.positive,
      recommendation:
          'Prioritize interactive video format for the upcoming Q4 Compliance rollout.',
    ),
  ];
}
