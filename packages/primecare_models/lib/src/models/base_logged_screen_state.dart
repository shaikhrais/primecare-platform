/// Shared storage for existing screen states with a title and activity log.
abstract class BaseLoggedScreenState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;

  const BaseLoggedScreenState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
  });
}
