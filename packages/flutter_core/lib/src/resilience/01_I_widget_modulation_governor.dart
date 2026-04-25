// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

/// A UI wrapper that automatically handles rendering based on the health of a subsystem.
///
/// If the required [subsystem] is degraded or offline, it can render an optional
/// [degradedBuilder] (e.g. an offline banner or a skeleton) while still rendering
/// the primary [child] (which should be populated with fallback blueprint data).
class WidgetModulationGovernor extends ConsumerWidget {
  final PlatformSubsystem subsystem;
  final Widget child;

  /// An optional builder to overlay or replace the child when degraded.
  final Widget Function(BuildContext context, ModulationState state)?
  degradedBuilder;

  const WidgetModulationGovernor({
    super.key,
    required this.subsystem,
    required this.child,
    this.degradedBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine modulation state for the UI badge
    final modulationState =
        ref.watch(modulationGovernanceProvider)[subsystem] ??
        ModulationState.healthy;

    // Evaluate policy strictly
    final canExecute = GovernancePolicyManager.evaluateDefault(
      modulationState,
      subsystem,
    );

    if (canExecute) {
      return child;
    }

    // Subsystem is degraded or offline.
    if (degradedBuilder != null) {
      return degradedBuilder!(context, modulationState);
    }

    // Default degraded rendering: dim the child and add an offline indicator.
    return Stack(
      children: [
        Opacity(
          opacity: 0.7,
          child: IgnorePointer(
            // Optionally disable interaction if offline, or leave enabled if we support offline actions.
            ignoring: modulationState == ModulationState.offline,
            child: child,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: _DefaultDegradedBadge(state: modulationState),
        ),
      ],
    );
  }
}

class _DefaultDegradedBadge extends StatelessWidget {
  final ModulationState state;

  const _DefaultDegradedBadge({required this.state});

  @override
  Widget build(BuildContext context) {
    final isOffline = state == ModulationState.offline;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isOffline
            ? Colors.red.withValues(alpha: 0.8)
            : Colors.orange.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOffline ? Icons.wifi_off : Icons.warning_amber_rounded,
            size: 12,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            isOffline ? 'Offline' : 'Degraded',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
