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
        int crossAxisCount;
        double extent = desktopMainAxisExtent;
        final width = constraints.maxWidth;

        if (width >= 3400) {
          crossAxisCount = 10; // 4K (3840px)
        } else if (width >= 2400) {
          crossAxisCount = 8;  // 3K (2560px)
        } else if (width >= 1900) {
          crossAxisCount = 6;  // 2K (2048px)
        } else if (width >= 1200) {
          crossAxisCount = 4;  // 1K / Desktop (1280px)
        } else if (width >= 768) {
          crossAxisCount = 2;  // Tablet
          extent = tabletMainAxisExtent;
        } else {
          crossAxisCount = 1;  // Mobile
          extent = mobileMainAxisExtent;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            mainAxisExtent: extent,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}
