import 'package:flutter/material.dart';

class RegionPerformanceCard extends StatelessWidget {
  final String region;
  final String facilityCount;
  final String revenue;
  final String margin;
  final Color? marginColor;

  const RegionPerformanceCard({
    super.key,
    required this.region,
    required this.facilityCount,
    required this.revenue,
    required this.margin,
    this.marginColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  region,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  facilityCount,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              revenue,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: (marginColor ?? Colors.green).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                margin,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: marginColor ?? Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
