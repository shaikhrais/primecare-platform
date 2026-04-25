// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '01_I_modulation_governance_registry.dart';
import '01_I_governance_policies.dart';

/// A utility to be used inside Riverpod Adapters/Providers.
///
/// Instead of checking `ref.read(isOnlineProvider)`, adapters use the AdapterModulationGovernor
/// to check if the specific subsystem they rely on is healthy.
///
/// Note: Legacy `canExecute` now forwards to the new OOP `GovernancePolicyManager`.
class AdapterModulationGovernor {
  /// Checks if the adapter should execute its normal data fetch, or if it should
  /// immediately return a fallback state because the subsystem is degraded.
  ///
  /// Uses the default [GovernancePolicy] mapped to the subsystem.
  ///
  /// Example Usage inside a FutureProvider:
  /// ```dart
  /// if (!AdapterModulationGovernor.canExecute(ref, PlatformSubsystem.metrics)) {
  ///   return DataLogisticsHub.getDashboardMetrics(role);
  /// }
  /// ```
  static bool canExecute(Ref ref, PlatformSubsystem subsystem) {
    final state =
        ref.watch(modulationGovernanceProvider)[subsystem] ??
        ModulationState.healthy;
    return GovernancePolicyManager.evaluateDefault(state, subsystem);
  }

  /// Checks if the adapter should execute using a specific custom policy.
  static bool canExecuteWithPolicy(
    Ref ref,
    PlatformSubsystem subsystem,
    GovernancePolicy policy,
  ) {
    final state =
        ref.watch(modulationGovernanceProvider)[subsystem] ??
        ModulationState.healthy;
    return GovernancePolicyManager.evaluateCustom(state, policy);
  }
}
