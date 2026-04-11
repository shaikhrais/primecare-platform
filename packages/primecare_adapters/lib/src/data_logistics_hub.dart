class DataLogisticsHub {
  /// Assembles the data payload from the API into strongly-typed UI components.
  /// If the API payload fails, times out, or throws an exception, this gracefully falls back
  /// to the [fallbackBuilder] so that the UI can assemble its offline/fallback views.
  static Future<T> fetchAndAssemble<T>({
    required Future<T> Function() fetchCall,
    required T Function() fallbackBuilder,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      return await fetchCall();
    } catch (e, st) {
      if (onError != null) {
        onError(e, st);
      } else {
        // Core telemetry logic could be injected here internally without UI components caring.
        print('[DataLogisticsHub] API Failure Caught: \$e. Emitting Fallback Blueprints.');
      }
      return fallbackBuilder();
    }
  }
}
