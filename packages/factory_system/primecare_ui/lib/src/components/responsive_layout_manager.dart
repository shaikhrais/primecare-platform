import 'package:flutter/material.dart';
import 'package:primecare_core/flutter_core.dart';

class ResponsiveLayoutManager extends StatelessWidget {
  final Widget mob;
  final Widget? tab;
  final Widget? oneK;
  final Widget? twoK;
  final Widget? threeK;
  final Widget? fourK;

  const ResponsiveLayoutManager({
    super.key,
    required this.mob,
    this.tab,
    this.oneK,
    this.twoK,
    this.threeK,
    this.fourK,
  });

  static ResolutionTier getTier(BuildContext context) =>
      ScreenBreakpoints.getTier(MediaQuery.of(context).size.width);

  static bool isMob(BuildContext context) =>
      getTier(context) == ResolutionTier.mob;
  static bool isTab(BuildContext context) =>
      getTier(context) == ResolutionTier.tab;
  static bool is1k(BuildContext context) =>
      getTier(context) == ResolutionTier.oneK;
  static bool is2k(BuildContext context) =>
      getTier(context) == ResolutionTier.twoK;
  static bool is3k(BuildContext context) =>
      getTier(context) == ResolutionTier.threeK;
  static bool is4k(BuildContext context) =>
      getTier(context) == ResolutionTier.fourK;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tier = ScreenBreakpoints.getTier(constraints.maxWidth);

        switch (tier) {
          case ResolutionTier.fourK:
            return fourK ?? threeK ?? twoK ?? oneK ?? tab ?? mob;
          case ResolutionTier.threeK:
            return threeK ?? twoK ?? oneK ?? tab ?? mob;
          case ResolutionTier.twoK:
            return twoK ?? oneK ?? tab ?? mob;
          case ResolutionTier.oneK:
            return oneK ?? tab ?? mob;
          case ResolutionTier.tab:
            return tab ?? mob;
          case ResolutionTier.mob:
            return mob;
        }
      },
    );
  }
}
