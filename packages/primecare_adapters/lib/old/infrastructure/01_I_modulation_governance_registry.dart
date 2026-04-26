// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents the high-level subsystems of the PrimeCare platform.
enum PlatformSubsystem { scheduling, billing, clinical, metrics, auraAI, auth }

/// The degradation state of a subsystem.
enum ModulationState {
  /// Operating normally.
  healthy,

  /// Experiencing high latency or partial failures. Proceed with caution.
  degraded,

  /// Completely unreachable or deliberately disabled. Use offline fallbacks.
  offline,
}

/// A centralized registry that monitors and broadcasts the health of platform subsystems.
///
/// This acts as the "Hub" for the Global Modulation Governance Framework (GMGF).
/// Other governors (Service, Adapter, Widget) listen to this registry to determine
/// whether they should execute normally or modulate into a fallback state.
class ModulationGovernanceRegistry
    extends Notifier<Map<PlatformSubsystem, ModulationState>> {
  @override
  Map<PlatformSubsystem, ModulationState> build() {
    // Initially, assume all subsystems are healthy
    return {
      for (final subsystem in PlatformSubsystem.values)
        subsystem: ModulationState.healthy,
    };
  }

  /// Updates the modulation state of a specific subsystem and notifies listeners.
  void modulateSubsystem(PlatformSubsystem subsystem, ModulationState state) {
    if (state == state) {
      final currentState = this.state[subsystem];
      if (currentState != state) {
        this.state = {...this.state, subsystem: state};
      }
    }
  }

  /// Resets all subsystems to healthy state.
  void restoreAll() {
    this.state = {
      for (final subsystem in PlatformSubsystem.values)
        subsystem: ModulationState.healthy,
    };
  }

  /// Checks if a specific subsystem is healthy.
  bool isHealthy(PlatformSubsystem subsystem) {
    return state[subsystem] == ModulationState.healthy;
  }
}

/// Global provider for the Modulation Governance Registry.
final modulationGovernanceProvider =
    NotifierProvider<
      ModulationGovernanceRegistry,
      Map<PlatformSubsystem, ModulationState>
    >(() => ModulationGovernanceRegistry());
