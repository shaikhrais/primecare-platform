import 'package:flutter/material.dart';

/// The Universal Vertical Array.
/// Designed to accept a 'gap' parameter to mathematically eliminate thousands of manual SizedBox spacings dynamically.
class PrimeCareColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final double gap;

  const PrimeCareColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.gap = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> spacedChildren = [];
    if (gap > 0.0) {
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1 && children[i] is! Expanded && children[i] is! Flexible && children[i] is! Spacer) {
           spacedChildren.add(SizedBox(height: gap));
        }
      }
    } else {
      spacedChildren = children;
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      verticalDirection: verticalDirection,
      children: spacedChildren,
    );
  }
}

/// The Universal Horizontal Array.
/// Designed to accept a 'gap' parameter to mathematically eliminate thousands of manual SizedBox spacings dynamically.
class PrimeCareRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final double gap;

  const PrimeCareRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.gap = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> spacedChildren = [];
    if (gap > 0.0) {
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1 && children[i] is! Expanded && children[i] is! Flexible && children[i] is! Spacer) {
           spacedChildren.add(SizedBox(width: gap));
        }
      }
    } else {
      spacedChildren = children;
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      verticalDirection: verticalDirection,
      children: spacedChildren,
    );
  }
}
