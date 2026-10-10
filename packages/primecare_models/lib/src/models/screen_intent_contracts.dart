/// Defines the recovery strategy for a screen when a critical failure occurs.
enum ScreenRecoveryStrategy {
  /// Simple soft reset of the current state.
  softReset,

  /// Full route restart, clearing history.
  routeRestart,

  /// Redirect to a safe fallback screen.
  fallbackRedirect,

  /// Escalate to the global System Recovery Mode.
  globalEscalation,
}

/// Defines the behavioral policy for a screen's resilience.
class ResiliencePolicy {
  final ScreenRecoveryStrategy strategy;
  final String? fallbackRoute;
  final Duration retryDelay;
  final int maxRetries;

  const ResiliencePolicy({
    this.strategy = ScreenRecoveryStrategy.softReset,
    this.fallbackRoute,
    this.retryDelay = const Duration(seconds: 2),
    this.maxRetries = 3,
  });
}

/// Represents the health state of a screen's governance.
class GovernanceHealth {
  final bool isReady;
  final String? message;

  const GovernanceHealth.healthy() : isReady = true, message = null;

  const GovernanceHealth.unhealthy(this.message) : isReady = false;
}

/// Exception thrown when a governed component is accessed before implementation.
class UnimplementedGovernanceException implements Exception {
  final String feature;
  final String component;

  UnimplementedGovernanceException(this.feature, this.component);

  @override
  String toString() =>
      'UnimplementedGovernanceException: [$feature] $component has not been developed yet. Please implement the adapter and screen logic.';
}
