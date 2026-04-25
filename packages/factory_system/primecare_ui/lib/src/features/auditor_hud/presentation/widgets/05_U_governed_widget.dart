// Layer: 05_UI_WIDGETS
import 'package:flutter/material.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

/// A wrapper for UI components that automatically disables or degrades them
/// based on the Global Modulation Governance Framework's assessment of their
/// underlying subsystem.
class GovernedWidget extends ConsumerWidget {
  final PlatformSubsystem subsystem;
  final Widget child;

  /// Optional builder to customize how the degraded/offline state looks.
  /// If null, a default visual degradation is applied.
  final Widget Function(
    BuildContext context,
    Widget child,
    ModulationState state,
  )?
  builder;

  const GovernedWidget({
    super.key,
    required this.subsystem,
    required this.child,
    this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final governanceState = ref.watch(modulationGovernanceProvider);
    final state = governanceState[subsystem] ?? ModulationState.healthy;

    if (builder != null) {
      return builder!(context, child, state);
    }

    switch (state) {
      case ModulationState.healthy:
        return child;
      case ModulationState.degraded:
        return Opacity(
          opacity: 0.7,
          child: Tooltip(
            message:
                'Subsystem is degraded. Operations may be slow or partially unavailable.',
            child: child,
          ),
        );
      case ModulationState.offline:
        return Opacity(
          opacity: 0.4,
          child: IgnorePointer(
            child: Tooltip(
              message: 'Subsystem is offline. Functionality disabled.',
              child: child,
            ),
          ),
        );
    }
  }
}
