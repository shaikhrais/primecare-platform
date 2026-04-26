import 'package:primecare_adapters/primecare_adapters.dart';

class QualityAssuranceDashboardViewModel extends PrimeCareDashboardViewModel {
  const QualityAssuranceDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory QualityAssuranceDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return QualityAssuranceDashboardViewModel(
      metrics: metrics,
      insights: const [],
    );
  }

  factory QualityAssuranceDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return QualityAssuranceDashboardViewModel(
      metrics: base.metrics,
      insights: base.insights,
      blueprints: base.blueprints,
      isOfflineFallback: base.isOfflineFallback,
    );
  }

  factory QualityAssuranceDashboardViewModel.empty({
    bool isOfflineFallback = false,
  }) {
    return QualityAssuranceDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
      blueprints: const [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  QualityAssuranceDashboardViewModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return QualityAssuranceDashboardViewModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      blueprints: blueprints ?? this.blueprints,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }
}
