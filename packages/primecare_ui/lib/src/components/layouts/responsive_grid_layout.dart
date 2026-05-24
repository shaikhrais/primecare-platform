// Governance - Category: view | Purpose: [Component] - Adaptive layouts for high-resolution and 4K workspaces.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// [Component] - Adaptive Grid Layout that adjusts columns dynamically from mobile to 4K displays.
/// Grid adjusts from 1 column (mobile), to 2 columns (tablet), to 4 columns (standard 1080p desktop), 
/// to 6 columns (large high-resolution and 4K displays) based on available constraints.
class ResponsiveGridLayout extends StatelessWidget {
  final List<Widget> children;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double maxAspectRatio;

  const ResponsiveGridLayout({
    super.key,
    required this.children,
    this.crossAxisSpacing = 16.0,
    this.mainAxisSpacing = 16.0,
    this.maxAspectRatio = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int cols = 1;
        double ratio = maxAspectRatio;

        if (width >= 2560) {
          // Large High-Res & 4K Displays
          cols = 6;
          ratio = 1.4;
        } else if (width >= 1440) {
          // Standard Desktop Monitors
          cols = 4;
          ratio = 1.3;
        } else if (width >= 768) {
          // Tablets & Small Screens
          cols = 2;
          ratio = 1.2;
        } else {
          // Mobile Devices
          cols = 1;
          ratio = 1.8;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: ratio,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}

/// [Component] - Dense high-fidelity table built specifically to display rich datasets on high-res monitors.
class DenseHighResTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final double rowHeight;
  final String title;

  const DenseHighResTable({
    super.key,
    required this.headers,
    required this.rows,
    this.rowHeight = 48.0,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Header Bar with dense controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colors.primary.withValues(alpha: 0.05),
                        border: Border.all(color: theme.colors.primary.withValues(alpha: 0.15)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'HIGH RESOLUTION DATA GRID',
                        style: theme.typography.labelBold.copyWith(
                          color: theme.colors.primary,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: theme.colors.divider, height: 1),
          // Scrollable Datagrid
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(theme.colors.surfaceContainer.withValues(alpha: 0.3)),
                  dataRowMinHeight: rowHeight,
                  dataRowMaxHeight: rowHeight,
                  columnSpacing: 40.0,
                  horizontalMargin: 24.0,
                  columns: headers
                      .map((h) => DataColumn(
                            label: Text(
                              h.toUpperCase(),
                              style: theme.typography.labelBold.copyWith(
                                color: theme.colors.onSurfaceVariant,
                                fontSize: 11,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ))
                      .toList(),
                  rows: rows
                      .map((row) => DataRow(
                            cells: row.map((cell) => DataCell(cell)).toList(),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// [Component] - Masonry-style Reflowable grid designed to create beautiful dashboard layouts on 4K/high-res screens.
class DynamicMasonryDashboardGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const DynamicMasonryDashboardGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int colCount = 1;

        if (width >= 2560) {
          colCount = 4;
        } else if (width >= 1440) {
          colCount = 3;
        } else if (width >= 768) {
          colCount = 2;
        } else {
          colCount = 1;
        }

        // Divide items evenly among columns
        List<List<Widget>> columns = List.generate(colCount, (_) => []);
        for (int i = 0; i < children.length; i++) {
          columns[i % colCount].add(children[i]);
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(colCount, (colIndex) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: colIndex > 0 ? spacing / 2 : 0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: columns[colIndex].map((item) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: item,
                    );
                  }).toList(),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
