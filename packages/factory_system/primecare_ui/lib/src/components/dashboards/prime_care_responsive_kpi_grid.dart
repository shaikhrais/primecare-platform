import 'package:flutter/material.dart';

class PrimeCareResponsiveKpiGrid extends StatelessWidget {
  final List<Widget> children;

  const PrimeCareResponsiveKpiGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint management: Mobile (1), Tablet (2), Desktop (4)
        int crossAxisCount = 1;
        if (constraints.maxWidth > 600) crossAxisCount = 2;
        if (constraints.maxWidth > 1024) crossAxisCount = 4;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio:
              1.8, // Adjusted height for resilient vertical stacking
          children: children,
        );
      },
    );
  }
}
