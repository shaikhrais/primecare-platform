import 'package:flutter/material.dart';

/// Layout-only chrome. Callers supply authorized, themed navigation/toolbar slots.
class NavbarChromeBar {
  final Widget child;
  final double extent;
  final bool fixed;
  final String id;
  const NavbarChromeBar({required this.id, required this.child, required this.extent, required this.fixed});
}

/// One header keeps fixed bars stacked while static bars scroll out independently.
class NavbarScrollHeader extends SliverPersistentHeaderDelegate {
  final List<NavbarChromeBar> bars;
  NavbarScrollHeader(this.bars);
  @override double get maxExtent => bars.fold(0, (total, bar) => total + bar.extent);
  @override double get minExtent => bars.where((bar) => bar.fixed).fold(0, (total, bar) => total + bar.extent);
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var remaining=shrinkOffset.clamp(0, maxExtent-minExtent).toDouble();
    final children=<Widget>[];
    for (final bar in bars) {
      final removed=bar.fixed?0.0:remaining.clamp(0,bar.extent).toDouble();
      remaining-=removed;
      final visible=bar.extent-removed;
      children.add(ExcludeFocus(excluding:visible<=0,child:ExcludeSemantics(excluding:visible<=0,
        child:SizedBox(key:ValueKey('navbar-scroll-${bar.id}'),height:visible,child:ClipRect(child:OverflowBox(
          alignment:Alignment.bottomCenter,minHeight:bar.extent,maxHeight:bar.extent,
          child:SizedBox(height:bar.extent,child:bar.child)))))));
    }
    return Column(mainAxisSize:MainAxisSize.min,children:children);
  }
  @override bool shouldRebuild(covariant NavbarScrollHeader oldDelegate) => true;
}
