import '01_I_modulation_governance_registry.dart';

/// Abstract base class for all Governance Policies using OOP principles.
abstract class GovernancePolicy {
  const GovernancePolicy();

  /// Evaluates whether an execution can proceed based on the subsystem's state.
  bool evaluate(ModulationState state);

  /// Allows the policy to define fallback behavior or metadata.
  String get policyName;
}

/// A strict policy that requires the subsystem to be fully healthy.
/// Typically used for critical operations like Billing or Authentication.
class StrictHealthPolicy extends GovernancePolicy {
  const StrictHealthPolicy();

  @override
  bool evaluate(ModulationState state) {
    return state == ModulationState.healthy;
  }

  @override
  String get policyName => 'StrictHealthPolicy';
}

/// A tolerant policy that allows execution even if the subsystem is degraded.
/// Typically used for analytics, metrics, or non-critical reads.
class DegradedTolerantPolicy extends GovernancePolicy {
  const DegradedTolerantPolicy();

  @override
  bool evaluate(ModulationState state) {
    return state == ModulationState.healthy ||
        state == ModulationState.degraded;
  }

  @override
  String get policyName => 'DegradedTolerantPolicy';
}

/// A policy that specifically blocks execution if the subsystem is offline.
/// Any other state (healthy, degraded) is permitted.
class OfflineBlockingPolicy extends GovernancePolicy {
  const OfflineBlockingPolicy();

  @override
  bool evaluate(ModulationState state) {
    return state != ModulationState.offline;
  }

  @override
  String get policyName => 'OfflineBlockingPolicy';
}

/// Centralized manager for applying Governance Policies.
class GovernancePolicyManager {
  static final Map<PlatformSubsystem, GovernancePolicy> _defaultPolicies = {
    PlatformSubsystem.billing: const StrictHealthPolicy(),
    PlatformSubsystem.clinical: const StrictHealthPolicy(),
    PlatformSubsystem.scheduling: const DegradedTolerantPolicy(),
    PlatformSubsystem.metrics: const DegradedTolerantPolicy(),
    PlatformSubsystem.auraAI: const OfflineBlockingPolicy(),
    PlatformSubsystem.auth: const StrictHealthPolicy(),
  };

  /// Evaluates the default policy assigned to the subsystem.
  static bool evaluateDefault(
    ModulationState state,
    PlatformSubsystem subsystem,
  ) {
    final policy = _defaultPolicies[subsystem] ?? const StrictHealthPolicy();
    return policy.evaluate(state);
  }

  /// Retrieves the name of the assigned default policy for auditing and reporting.
  static String getDefaultPolicyName(PlatformSubsystem subsystem) {
    final policy = _defaultPolicies[subsystem] ?? const StrictHealthPolicy();
    return policy.policyName;
  }

  /// Evaluates a specific custom policy against a subsystem state.
  static bool evaluateCustom(
    ModulationState state,
    GovernancePolicy customPolicy,
  ) {
    return customPolicy.evaluate(state);
  }
}
