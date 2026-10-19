import 'base_logged_screen_state.dart';

/// Existing workspace screen state, shared by API and UI consumers.
abstract class BaseWorkspaceState<T extends BaseWorkspaceState<T>>
    extends BaseLoggedScreenState {
  final bool hasData;

  const BaseWorkspaceState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
    required this.hasData,
  });

  T rebuild({
    required bool isLoading,
    required String? error,
    required String title,
    required List<String> logs,
    required bool hasData,
  });

  T copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
    bool? hasData,
  }) => rebuild(
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
    title: title ?? this.title,
    logs: logs ?? this.logs,
    hasData: hasData ?? this.hasData,
  );
}
