import 'package:flutter/widgets.dart';

/// Responsive columns whose cards keep the height required by their content.
/// Text scaling can add lines without clipping a fixed grid tile.
class PrimeContentGrid extends StatelessWidget {
  final List<Widget> children;
  final double maxCrossAxisExtent;
  final double spacing;
  final double runSpacing;

  const PrimeContentGrid({
    super.key,
    required this.children,
    required this.maxCrossAxisExtent,
    this.spacing = 16,
    this.runSpacing = 16,
  }) : assert(maxCrossAxisExtent > 0 && maxCrossAxisExtent < double.infinity),
       assert(spacing >= 0 && spacing < double.infinity),
       assert(runSpacing >= 0 && runSpacing < double.infinity);

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(builder: (context, constraints) {
      assert(constraints.hasBoundedWidth, 'PrimeContentGrid needs bounded width');
      final width = constraints.maxWidth;
      final columns = width > 0 ? (width / (maxCrossAxisExtent + spacing)).ceil() : 1;
      final itemWidth = (width - spacing * (columns - 1)) / columns;
      return Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: [for (final child in children) SizedBox(width: itemWidth, child: child)],
      );
    });
  }
}
