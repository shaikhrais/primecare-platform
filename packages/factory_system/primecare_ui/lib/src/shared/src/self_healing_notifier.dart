// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/shared/primecare_adapters.dart';

/// SystemVerificationState of the self-healing engine.
class SelfHealingState {
  /// Map of route IDs to retry attempts.
  final Map<String, int> retryCounts;

  /// If true, the platform is in a "lockout" state due to a critical failure.
  final bool isLockoutActive;

  /// The route ID of the critical failure that triggered the lockout.
  final String? failingRouteId;

  const SelfHealingState({
    this.retryCounts = const {},
    this.isLockoutActive = false,
    this.failingRouteId,
  });

  SelfHealingState copyWith({
    Map<String, int>? retryCounts,
    bool? isLockoutActive,
    String? failingRouteId,
  }) {
    return SelfHealingState(
      retryCounts: retryCounts ?? this.retryCounts,
      isLockoutActive: isLockoutActive ?? this.isLockoutActive,
      failingRouteId: failingRouteId ?? this.failingRouteId,
    );
  }
}

/// A notifier that manages the platform's self-healing logic.
///
/// It tracks retry attempts for hydration and triggers safety redirects
/// when critical thresholds are exceeded.
class SelfHealingNotifier extends StateNotifier<SelfHealingState> {
  final Ref ref;
  static const int maxRetries = 3;

  SelfHealingNotifier(this.ref) : super(const SelfHealingState());

  /// Records a failure for a specific route and returns true if a retry should be attempted.
  bool recordFailure(String routeId, {bool isCritical = false}) {
    if (state.isLockoutActive) return false;

    final currentRetries = state.retryCounts[routeId] ?? 0;

    if (currentRetries >= maxRetries) {
      if (isCritical) {
        _triggerLockout(routeId);
      }
      return false;
    }

    final updatedCounts = Map<String, int>.from(state.retryCounts);
    updatedCounts[routeId] = currentRetries + 1;

    state = state.copyWith(retryCounts: updatedCounts);
    return true;
  }

  /// Resets the retry count for a route (e.g., after a successful hydration).
  void resetRetryCount(String routeId) {
    if (state.retryCounts.containsKey(routeId)) {
      final updatedCounts = Map<String, int>.from(state.retryCounts);
      updatedCounts.remove(routeId);
      state = state.copyWith(retryCounts: updatedCounts);
    }
  }

  /// Manually clears the lockout state.
  void clearLockout() {
    state = state.copyWith(
      isLockoutActive: false,
      failingRouteId: null,
      retryCounts: {}, // Clear all counts on manual reset
    );
  }

  void _triggerLockout(String routeId) {
    state = state.copyWith(isLockoutActive: true, failingRouteId: routeId);
  }
}

/// Provider for the [SelfHealingNotifier].
final selfHealingProvider =
    StateNotifierProvider<SelfHealingNotifier, SelfHealingState>((ref) {
      return SelfHealingNotifier(ref);
    });
