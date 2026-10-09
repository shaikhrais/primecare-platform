import 'base_logged_screen_state.dart';

class PatientChartingState extends BaseLoggedScreenState {
  const PatientChartingState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
  });

  PatientChartingState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return PatientChartingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}
