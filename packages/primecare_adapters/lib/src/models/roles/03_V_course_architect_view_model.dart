// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../corporate/02_M_training_models.dart';

class CourseArchitectViewModel extends PrimeCareDashboardViewModel {
  final List<TrainingModuleModel> availableModules;

  const CourseArchitectViewModel({
    required this.availableModules,
    required super.metrics,
    required super.insights,
    super.isOfflineFallback,
  });

  factory CourseArchitectViewModel.fromJson(Map<String, dynamic> json) {
    return CourseArchitectViewModel(
      availableModules: (json['availableModules'] as List<dynamic>? ?? [])
          .map((e) => TrainingModuleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      metrics: DashboardMetrics.fromJson(
        json['metrics'] as Map<String, dynamic>? ?? {},
      ),
      insights: [],
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
    );
  }

  factory CourseArchitectViewModel.empty() {
    return CourseArchitectViewModel(
      availableModules: const [],
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'availableModules': availableModules.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [...super.props, availableModules];
}
