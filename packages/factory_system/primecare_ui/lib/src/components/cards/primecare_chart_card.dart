import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCareChartCard extends ConsumerWidget {
  final String title;
  final Widget chart;
  final bool isPinned;
  final bool isAuraSupported;
  final bool isAuraActive;
  final VoidCallback? onPinToggle;
  final VoidCallback? onAuraToggle;
  final VoidCallback? onDetailPressed;

  const PrimeCareChartCard({
    super.key,
    required this.title,
    required this.chart,
    this.isPinned = false,
    this.isAuraSupported = false,
    this.isAuraActive = false,
    this.onPinToggle,
    this.onAuraToggle,
    this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.auraEngine,
          'Building Chart: $title (Aura Supported: $isAuraSupported, Active: $isAuraActive)',
        );
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B262C),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: PrimeCareColors.black.withAlpha(20),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: PrimeCareColors.white,
                      ),
                    ),
                    if (isAuraActive) ...[
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: PrimeCareColors.purple.withAlpha(30),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'AURA ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: PrimeCareColors.purple,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    if (isAuraSupported)
                      _buildHeaderButton(
                        icon: LucideIcons.sparkles,
                        isActive: isAuraActive,
                        activeColor: PrimeCareColors.purple,
                        onPressed: () {
                          ref
                              .read(executionGateProvider)
                              .passGate(
                                ExecutionGateCategory.auraEngine,
                                'Toggling Aura Forecast for $title',
                                metadata: {'active': !isAuraActive},
                              );
                          onAuraToggle?.call();
                        },
                        tooltip: isAuraActive
                            ? 'Disable Aura Analysis'
                            : 'Enable Aura Forecast',
                      ),
                    if (onDetailPressed != null)
                      _buildHeaderButton(
                        icon: LucideIcons.externalLink,
                        isActive: false,
                        activeColor: PrimeCareColors.skyBlue,
                        onPressed: () {
                          ref
                              .read(executionGateProvider)
                              .passGate(
                                ExecutionGateCategory.navigationLayer,
                                'Navigating to Details from $title',
                              );
                          onDetailPressed?.call();
                        },
                        tooltip: 'View detailed report',
                      ),
                    _buildHeaderButton(
                      icon: isPinned ? LucideIcons.pin : LucideIcons.pinOff,
                      isActive: isPinned,
                      activeColor: PrimeCareColors.skyBlue,
                      onPressed: () {
                        ref
                            .read(executionGateProvider)
                            .passGate(
                              ExecutionGateCategory.ui,
                              'Toggling Pin for $title',
                              metadata: {'pinned': !isPinned},
                            );
                        onPinToggle?.call();
                      },
                      tooltip: isPinned ? 'Unpin from top' : 'Pin to top',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            chart,
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required bool isActive,
    required Color activeColor,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withAlpha(30)
              : PrimeCareColors.white.withAlpha(5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isActive ? activeColor : PrimeCareColors.white.withAlpha(100),
        ),
      ),
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }
}
