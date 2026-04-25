// Layer: 01_INFRASTRUCTURE
import '../../primecare_core.dart';

/// A mixin designed to be applied to Domain Services.
///
/// It intercepts network calls using the GMGF (Global Modulation Governance Framework).
/// If the targeted subsystem is degraded or offline, it preemptively fails the call
/// without hitting the network, saving resources and timeouts.
mixin ServiceModulationGovernor {
  /// Executes a future, guarded by the Modulation Registry.
  ///
  /// If the [subsystem] is currently NOT healthy, this will instantly return a
  /// fallback [Result.error] without executing the computation.
  Future<Result<T>> executeGovernedFuture<T>({
    required Ref ref,
    required PlatformSubsystem subsystem,
    required Future<T> Function() computation,
    required T Function(Object error, StackTrace stackTrace) onErrorFallback,
  }) async {
    final modulationState = ref.read(modulationGovernanceProvider)[subsystem];

    if (modulationState == ModulationState.offline ||
        modulationState == ModulationState.degraded) {
      // Preemptive integration modulation: Do not execute network call.
      // Return a controlled fallback Result.
      return Result.guardFuture<T>(
        () async => throw Exception(
          'Subsystem [${subsystem.name}] is currently ${modulationState?.name ?? 'unknown'}. Call preempted by ServiceModulationGovernor.',
        ),
        onError: onErrorFallback,
      );
    }

    // Subsystem is healthy, proceed with standard execution and Result guard.
    return Result.guardFuture<T>(computation, onError: onErrorFallback);
  }
}
