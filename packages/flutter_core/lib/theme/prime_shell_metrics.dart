import 'package:flutter/material.dart';

/// Reference src/styles/index.css overrides md to 60rem (960px).
/// ToolbarLayout1/2 and FooterLayout1/2 use min-h-12 md:min-h-16.
abstract final class PrimeShellMetrics {
  static const desktopBreakpoint = 960.0;
  static const horizontalNavbarHeight = 64.0;
  static const dividerExtent = 1.0;
  static double barHeight(double viewportWidth) => viewportWidth >= desktopBreakpoint ? 64 : 48;
  static double toolbarExtent(double width, {required bool horizontal}) => barHeight(width)+(horizontal?dividerExtent:0);
  static double footerExtent(double width) => barHeight(width)+dividerExtent;
}

/// Border occupies its own pixel, matching the reference AppBar plus Toolbar.
class PrimeShellBarFrame extends StatelessWidget {
  final Widget child;
  final bool top, bordered;
  const PrimeShellBarFrame({super.key,required this.child,this.top=false,this.bordered=true});
  @override Widget build(BuildContext context) {
    if(!bordered)return child;
    final side=BorderSide(color:Theme.of(context).dividerColor,width:PrimeShellMetrics.dividerExtent);
    return DecoratedBox(decoration:BoxDecoration(border:top?Border(top:side):Border(bottom:side)),
      child:Padding(padding:top?const EdgeInsets.only(top:PrimeShellMetrics.dividerExtent):const EdgeInsets.only(bottom:PrimeShellMetrics.dividerExtent),child:child));
  }
}
