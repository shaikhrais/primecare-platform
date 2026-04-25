// Layer: 05_UI_WIDGETS
import 'package:flutter/material.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

/// A global overlay that allows privileged users (Auditors/Admins) to visually
/// monitor and manually toggle the ModulationState of all platform subsystems.
///
/// This acts as the visual counterpart to the Global Modulation Governance Framework,
/// enabling real-time fallback and degraded-state testing without severing physical
/// network connections.
class AuditorHudOverlay extends ConsumerStatefulWidget {
  final Widget child;

  const AuditorHudOverlay({super.key, required this.child});

  @override
  ConsumerState<AuditorHudOverlay> createState() => _AuditorHudOverlayState();
}

class _AuditorHudOverlayState extends ConsumerState<AuditorHudOverlay> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          // Main Application Content
          widget.child,

          // Auditor HUD Panel
          if (_isOpen)
            Positioned(
              right: 16,
              bottom: 80,
              width: 320,
              child: const Material(
                elevation: 12,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: _AuditorHudPanel(),
              ),
            ),

          // Floating Action Button to toggle HUD
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              heroTag: 'auditor_hud_fab',
              backgroundColor: Colors.black87,
              onPressed: () {
                setState(() {
                  _isOpen = !_isOpen;
                });
              },
              child: const Icon(Icons.security, color: Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuditorHudPanel extends ConsumerWidget {
  const _AuditorHudPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the registry directly to rebuild the UI when states change
    final governanceState = ref.watch(modulationGovernanceProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Auditor HUD',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Global Modulation Governance',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const Divider(height: 24),

          // Map through all known subsystems and render a control row
          ...PlatformSubsystem.values.map((subsystem) {
            final state = governanceState[subsystem] ?? ModulationState.healthy;
            return _SubsystemRow(
              subsystem: subsystem,
              state: state,
              onStateChanged: (newState) {
                if (newState != null) {
                  ref
                      .read(modulationGovernanceProvider.notifier)
                      .modulateSubsystem(subsystem, newState);
                }
              },
            );
          }).toList(),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                side: const BorderSide(color: Colors.green),
              ),
              onPressed: () {
                ref.read(modulationGovernanceProvider.notifier).restoreAll();
              },
              child: const Text('Restore All Healthy'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubsystemRow extends StatelessWidget {
  final PlatformSubsystem subsystem;
  final ModulationState state;
  final ValueChanged<ModulationState?> onStateChanged;

  const _SubsystemRow({
    required this.subsystem,
    required this.state,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color indicatorColor;
    switch (state) {
      case ModulationState.healthy:
        indicatorColor = Colors.green;
        break;
      case ModulationState.degraded:
        indicatorColor = Colors.orange;
        break;
      case ModulationState.offline:
        indicatorColor = Colors.red;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: indicatorColor,
                  boxShadow: [
                    BoxShadow(
                      color: indicatorColor.withValues(alpha: 0.4),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                subsystem.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          DropdownButton<ModulationState>(
            value: state,
            isDense: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down, size: 20),
            items: ModulationState.values.map((s) {
              return DropdownMenuItem(
                value: s,
                child: Text(
                  s.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: s == state ? Colors.black87 : Colors.grey.shade600,
                  ),
                ),
              );
            }).toList(),
            onChanged: onStateChanged,
          ),
        ],
      ),
    );
  }
}
