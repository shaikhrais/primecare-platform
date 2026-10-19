import 'base_logged_screen_state.dart';

class TreatmentNotesState extends BaseLoggedScreenState {
  const TreatmentNotesState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
  });

  TreatmentNotesState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return TreatmentNotesState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}
