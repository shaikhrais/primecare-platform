import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PrimeCareChartCard extends StatelessWidget {
  final String title;
  final Widget chart;
  final bool isPinned;
  final VoidCallback? onPinToggle;

  const PrimeCareChartCard({
    super.key,
    required this.title,
    required this.chart,
    this.isPinned = false,
    this.onPinToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
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
            const SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }
}
