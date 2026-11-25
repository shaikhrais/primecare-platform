// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE A wrapper component that arranges its children in a responsive grid. Instead of artificially...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import '../../config/screen_breakpoints.dart';
import '../../config/adaptive_scaling_config.dart';

/// A wrapper component that arranges its children in a responsive grid.
/// Instead of artificially scaling UI components on 4K displays, this uses
/// the available horizontal space to display more columns, increasing data density.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final double minItemWidth;
  final double maxItemWidth;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.minItemWidth = 280.0,
    this.maxItemWidth = 450.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tier = ScreenBreakpoints.getTier(MediaQuery.of(context).size.width);
        final spacingMultiplier = AdaptiveScalingConfig.getSpacingMultiplier(tier);

        final adjustedSpacing = spacing * spacingMultiplier;
        final adjustedRunSpacing = runSpacing * spacingMultiplier;

        // "Flow Over Scaling" - calculate how many items fit naturally
        // based on the minItemWidth, and distribute remaining space equally
        // but capping at maxItemWidth to avoid 'oversized cards'.
        
        // Calculate max possible items per row
        int cardsPerRow = (constraints.maxWidth + adjustedSpacing) ~/ (minItemWidth + adjustedSpacing);
        if (cardsPerRow == 0) cardsPerRow = 1;

        // Calculate actual item width to fill the row evenly
        double calculatedWidth = (constraints.maxWidth - (adjustedSpacing * (cardsPerRow - 1))) / cardsPerRow;
        
        // Clamp to avoid oversizing on very wide screens or when there are few items
        // For example on 4K, instead of stretching 2 cards to 1500px each, they will stop at maxItemWidth
        final double itemWidth = calculatedWidth.clamp(minItemWidth, maxItemWidth);

        return Wrap(
          spacing: adjustedSpacing,
          runSpacing: adjustedRunSpacing,
          alignment: WrapAlignment.start,
          children: children.map((child) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: minItemWidth,
                maxWidth: itemWidth,
              ),
              child: SizedBox(
                width: itemWidth,
                child: child,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
