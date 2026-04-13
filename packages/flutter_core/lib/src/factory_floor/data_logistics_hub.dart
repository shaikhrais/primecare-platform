/// Core Data Logistics Hub for the PrimeCare Platform.
/// Provides a unified mechanism for API hydration with automatic fallback to offline blueprints.
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
        // print('[DataLogisticsHub] API Failure Caught: $e. Emitting Fallback Blueprints.');
      }
      return fallbackBuilder();
    }
  }
}
