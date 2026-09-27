// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE Defines the recovery strategy for a screen when a critical failure occurs. Simple soft reset...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import '../platform_role.dart';
import '../../models/platform_types.dart';

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

/// A high-fidelity contract representing a screen's intent, dependencies, and resilience.
/// This class enables advanced governance by making screen requirements explicit.
abstract class AppScreenIntent {
  const AppScreenIntent();

  /// The canonical name for the registry.
  String get name;

  /// The global intent identifier matching the Prisma UIIntent database schema.
  String get intentId => name.replaceAll('_', '-');

  /// The canonical route or identifier for this screen.
  String get route => '/\$name';

  /// The human-readable title for the application shell.
  String get title;

  /// A descriptive subtitle or status message.
  String get subtitle => 'Governed Portal for \$title';

  /// The required role to access this screen.
  /// If null, it is considered a public or common screen.
  PlatformRole? get requiredRole => null;

  /// The primary data provider for this screen (usually an Adapter Provider).
  dynamic get provider => null;

  /// Explicit list of Riverpod providers this screen requires.
  /// Used by the Governance system to verify "Hydration Readiness".
  List<dynamic> get dependencies => provider != null ? [provider!] : [];

  /// The governance policy for resilience and recovery.
  ResiliencePolicy get resiliencePolicy => const ResiliencePolicy();

  /// The primary subsystem this screen relies on.
  /// If provided, the UI will automatically modulate based on this subsystem's health.
  PlatformSubsystem? get primarySubsystem => null;

  /// Builds the UI representation of this intent.
  Widget build(BuildContext context);

  /// Performs a pre-flight check to ensure the system is ready for this screen.
  /// Returns a [GovernanceHealth] report.
  GovernanceHealth verifyReady(dynamic ref) {
    for (final dynamic dep in dependencies) {
      try {
        // ignore: argument_type_not_assignable, avoid_dynamic_calls
        final Object? state = ref.read(dep);
        if (state == null) {
          return GovernanceHealth.unhealthy(
            'Dependency ${dep.runtimeType} is null',
          );
        }
      } catch (e) {
        return GovernanceHealth.unhealthy(
          'Dependency ${dep.runtimeType} failed: $e',
        );
      }
    }
    return const GovernanceHealth.healthy();
  }
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
