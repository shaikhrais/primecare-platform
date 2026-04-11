import 'package:flutter/material.dart';

class PrimeCareResponsiveKpiGrid extends StatelessWidget {
  final List<Widget> children;

  const PrimeCareResponsiveKpiGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1; // Default to mobile
        if (constraints.maxWidth > 1024) {
          crossAxisCount = 3; // Desktop
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2; // Tablet
        }

        // If there are exactly 2 children but 3 columns available, scale up their width or just utilize Wrap
        // A Wrap with calculate child width is safer than GridView if elements have dynamic height.

        double spacing = 16.0;
        int activeCols = children.length < crossAxisCount
            ? children.length
            : crossAxisCount;
        if (activeCols == 0) activeCols = 1;

        double childWidth =
            (constraints.maxWidth - (spacing * (activeCols - 1))) / activeCols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children
              .map((c) => SizedBox(width: childWidth, child: c))
              .toList(),
        );
      },
    );
  }
}
