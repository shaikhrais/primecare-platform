// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';

/// A row-based container for grid-snapping children.
/// Children must be of type [ResponsiveGridCol].
class ResponsiveGridRow extends ConsumerWidget {
  final List<ResponsiveGridCol> children;
  final double? spacing;
  final double? runSpacing;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveGridRow({
    super.key,
    required this.children,
    this.spacing,
    this.runSpacing,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveSpacing = spacing ?? 0;
        final rowWidth = constraints.maxWidth;

        // Ensure totalColumns is valid
        final totalCols = layout.totalColumns;
        if (totalCols <= 0 || rowWidth <= 0) return const SizedBox.shrink();

        // Calculate maximum required spacing width total for the total columns grid
        final totalGutterWidth = effectiveSpacing * (totalCols - 1);
        final pureGridWidth = rowWidth - totalGutterWidth;
        final unitWidth = pureGridWidth / totalCols;

        return Wrap(
          spacing: effectiveSpacing,
          runSpacing: runSpacing ?? 16,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: children.map((col) {
            // Apply standard mathematical calculation to get the actual px width
            final targetSpan = col.span > totalCols ? totalCols : col.span;
            double colWidth =
                (unitWidth * targetSpan) +
                (effectiveSpacing * (targetSpan - 1));

            // Fix rounding errors that could cause overflow to next line
            if (colWidth > rowWidth - 0.5) colWidth = rowWidth;

            // Slight bounded float safety for Wrap breaking
            colWidth = colWidth - 0.1;

            return Container(
              width: colWidth < 0 ? 0 : colWidth,
              padding: col.padding,
              child: col.child,
            );
          }).toList(),
        );
      },
    );
  }
}

/// A layout component that acts as metadata defining the specific number of columns in the PrimeCare grid layout.
class ResponsiveGridCol extends StatelessWidget {
  final int span;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ResponsiveGridCol({
    super.key,
    required this.span,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
