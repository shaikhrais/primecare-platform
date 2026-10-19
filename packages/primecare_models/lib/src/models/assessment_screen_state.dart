import 'base_logged_screen_state.dart';

class AssessmentState extends BaseLoggedScreenState {
  const AssessmentState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
  });

  AssessmentState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return AssessmentState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}
