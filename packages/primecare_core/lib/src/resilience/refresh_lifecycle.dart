// Governance - Category: controller | Purpose: Layer: 01_INFRASTRUCTURE A time-to-live (TTL) auto-invalidation utility for FutureProviders. Prevents stale cached da...
// Layer: 01_INFRASTRUCTURE
import 'dart:async';

/// Schedules refresh callbacks and registers cancellation with their owner.
/// The owner decides what invalidation means and when it is disposed.
class RefreshLifecycle {
  static void autoInvalidate({
    required void Function() invalidate,
    required void Function(void Function()) onDispose,
    Duration duration = const Duration(minutes: 5),
  }) {
    final timer = Timer(duration, () {
      invalidate();
    });

    onDispose(() => timer.cancel());
  }

  static void periodicRefresh({
    required void Function() invalidate,
    required void Function(void Function()) onDispose,
    Duration interval = const Duration(minutes: 5),
  }) {
    final timer = Timer.periodic(interval, (_) {
      invalidate();
    });

    onDispose(() => timer.cancel());
  }
}
