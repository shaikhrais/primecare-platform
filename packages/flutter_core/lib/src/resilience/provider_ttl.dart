import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A time-to-live (TTL) auto-invalidation utility for FutureProviders.
///
/// Prevents stale cached data by automatically invalidating providers
/// after a configurable duration. Critical for long-running healthcare sessions
/// where nurses may keep the app open for 8+ hours.
///
/// Usage:
/// ```dart
/// final myDataProvider = FutureProvider<MyModel>((ref) async {
///   // Auto-invalidate this provider every 5 minutes
///   ProviderTTL.autoInvalidate(ref, duration: Duration(minutes: 5));
///
///   final service = MyService(ref);
///   return service.fetchData();
/// });
/// ```
class ProviderTTL {
  /// Schedules automatic invalidation of the calling provider after [duration].
  ///
  /// When the timer fires, [ref.invalidateSelf()] is called, causing the
  /// provider to re-fetch fresh data on the next read.
  ///
  /// The timer is automatically cancelled if the provider is disposed
  /// (e.g., when the widget that depends on it is unmounted).
  static void autoInvalidate(
    Ref ref, {
    Duration duration = const Duration(minutes: 5),
  }) {
    final timer = Timer(duration, () {
      ref.invalidateSelf();
    });

    ref.onDispose(() => timer.cancel());
  }

  /// Schedules periodic refresh of the calling provider at [interval].
  ///
  /// Unlike [autoInvalidate] which fires once, this refreshes repeatedly
  /// at the given interval for the entire lifetime of the provider.
  ///
  /// Usage:
  /// ```dart
  /// final liveMetricsProvider = FutureProvider.autoDispose<Metrics>((ref) async {
  ///   ProviderTTL.periodicRefresh(ref, interval: Duration(minutes: 2));
  ///   return metricsService.fetchLatest();
  /// });
  /// ```
  static void periodicRefresh(
    Ref ref, {
    Duration interval = const Duration(minutes: 5),
  }) {
    final timer = Timer.periodic(interval, (_) {
      ref.invalidateSelf();
    });

    ref.onDispose(() => timer.cancel());
  }
}
