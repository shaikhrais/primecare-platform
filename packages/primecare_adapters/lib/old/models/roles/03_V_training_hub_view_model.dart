// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';
import '../corporate/02_M_training_models.dart';

class TrainingHubViewModel extends PrimeCareDashboardViewModel {
  final List<CurriculumModel> curricula;
  final List<CertificationModel> certifications;

  const TrainingHubViewModel({
    required this.curricula,
    required this.certifications,
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory TrainingHubViewModel.fromJson(Map<String, dynamic> json) {
    return TrainingHubViewModel(
      curricula: (json['curricula'] as List<dynamic>? ?? [])
          .map((e) => CurriculumModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      certifications: (json['certifications'] as List<dynamic>? ?? [])
          .map((e) => CertificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      metrics: DashboardMetrics.fromJson(
        json['metrics'] as Map<String, dynamic>? ?? {},
      ),
      insights: [],
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
    );
  }

  factory TrainingHubViewModel.empty() {
    return TrainingHubViewModel(
      curricula: const [],
      certifications: const [],
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }

  TrainingHubViewModel copyWith({
    List<CurriculumModel>? curricula,
    List<CertificationModel>? certifications,
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return TrainingHubViewModel(
      curricula: curricula ?? this.curricula,
      certifications: certifications ?? this.certifications,
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      blueprints: blueprints ?? this.blueprints,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'curricula': curricula.map((e) => e.toJson()).toList(),
    'certifications': certifications.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [...super.props, curricula, certifications];
}
