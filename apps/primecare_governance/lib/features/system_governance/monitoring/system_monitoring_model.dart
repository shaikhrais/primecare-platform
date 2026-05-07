class SystemMonitoringState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? metrics;

  const SystemMonitoringState({
    this.isLoading = true,
    this.error,
    this.metrics,
  });

  SystemMonitoringState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? metrics,
  }) {
    return SystemMonitoringState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      metrics: metrics ?? this.metrics,
    );
  }
}
