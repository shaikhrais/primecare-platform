import 'package:flutter/material.dart';

/// A unified responsive grid builder for PrimeCare dashboards.
/// It automatically scales from 4 columns (Desktop) down to 2 (Tablet) and 1 (Mobile).
class PrimeResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double desktopMainAxisExtent;
  final double tabletMainAxisExtent;
  final double mobileMainAxisExtent;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int desktopCrossAxisCount;

  const PrimeResponsiveGrid({
    super.key,
    required this.children,
    this.desktopMainAxisExtent = 160.0,
    this.tabletMainAxisExtent = 180.0,
    this.mobileMainAxisExtent = 200.0,
    this.crossAxisSpacing = 16.0,
    this.mainAxisSpacing = 16.0,
    this.desktopCrossAxisCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = desktopCrossAxisCount;
        double extent = desktopMainAxisExtent;
        
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
          extent = mobileMainAxisExtent;
        } else if (constraints.maxWidth < 1100) {
          crossAxisCount = 2;
          extent = tabletMainAxisExtent;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            mainAxisExtent: extent, // Fixed height for rigid aesthetic control
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}
