import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PrimeCareChartCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isAuraActive
              ? const Color(0xFF6366F1).withValues(alpha: 0.5)
              : const Color(0xFFE2E8F0),
          width: isAuraActive ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    if (isAuraActive) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'AURA ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4338CA),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    if (isAuraSupported)
                      IconButton(
                        icon: Icon(
                          LucideIcons.sparkles,
                          size: 18,
                          color: isAuraActive
                              ? const Color(0xFF6366F1)
                              : const Color(0xFF94A3B8),
                        ),
                        onPressed: onAuraToggle,
                        tooltip: isAuraActive
                            ? 'Disable Aura Analysis'
                            : 'Enable Aura Forecast',
                      ),
                    if (onDetailPressed != null)
                      IconButton(
                        icon: const Icon(
                          LucideIcons.externalLink,
                          size: 18,
                          color: Color(0xFF94A3B8),
                        ),
                        onPressed: onDetailPressed,
                        tooltip: 'View detailed report',
                      ),
                    IconButton(
                      icon: Icon(
                        isPinned ? LucideIcons.pin : LucideIcons.pinOff,
                        size: 18,
                        color: isPinned
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF94A3B8),
                      ),
                      onPressed: onPinToggle,
                      tooltip: isPinned ? 'Unpin from top' : 'Pin to top',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }
}
