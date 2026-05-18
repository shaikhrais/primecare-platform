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

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tier = ScreenBreakpoints.getTier(MediaQuery.of(context).size.width);
        final gridColumns = AdaptiveScalingConfig.getGridColumns(tier);
        final spacingMultiplier = AdaptiveScalingConfig.getSpacingMultiplier(tier);

        final adjustedSpacing = spacing * spacingMultiplier;
        final adjustedRunSpacing = runSpacing * spacingMultiplier;

        // Calculate item width based on grid columns
        // Assuming 4 columns is the base standard (1 unit) for Mobile,
        // so a standard card might want to span 4 columns out of the available.
        // For example, on 4K (20 columns), we can fit 5 cards of 4-column span.
        
        // This is a simplified wrap flow: we let children define their max bounds,
        // but typically a responsive grid card would use 1/N of the width.
        // If we treat "1 card" as "4 columns wide":
        final int cardsPerRow = (gridColumns / 4).floor().clamp(1, 10);
        final double itemWidth = (constraints.maxWidth - (adjustedSpacing * (cardsPerRow - 1))) / cardsPerRow;

        return Wrap(
          spacing: adjustedSpacing,
          runSpacing: adjustedRunSpacing,
          children: children.map((child) {
            return SizedBox(
              width: itemWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}
