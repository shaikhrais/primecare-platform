import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/config/screen_breakpoints.dart';
import 'package:primecare_core/providers/portal_providers.dart';
import '../theme/theme_tokens.dart';

class PrimeCareResponsiveKpiGrid extends ConsumerWidget {
  final List<Widget> children;

  const PrimeCareResponsiveKpiGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = switch (layout.tier) {
          ResolutionTier.mega => 6,
          ResolutionTier.fourK => 5,
          ResolutionTier.threeK || ResolutionTier.twoK => 4,
          ResolutionTier.oneK => 3,
          ResolutionTier.tab => 2,
          ResolutionTier.mob => 1,
        };

        double spacing = PrimeCareSpacing.md * scale;
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
