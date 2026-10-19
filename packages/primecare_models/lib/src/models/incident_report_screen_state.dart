import 'base_logged_screen_state.dart';

class IncidentReportState extends BaseLoggedScreenState {
  const IncidentReportState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
  });

  IncidentReportState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return IncidentReportState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}
