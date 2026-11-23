import 'package:flutter/material.dart';
import 'prime_theme_center_style.dart';

/// Reference src/styles/index.css overrides md to 60rem (960px).
/// ToolbarLayout1/2 and FooterLayout1/2 use min-h-12 md:min-h-16.
abstract final class PrimeShellMetrics {
  static const desktopBreakpoint = 960.0;
  static const horizontalNavbarHeight = 64.0;
  static const expandedNavigationWidth = 280;
  static const dividerExtent = 1.0;
  static const sidebarHeaderInset = 20.0;
  static const sidebarLogoExtent = 24.0;
  static const sidebarRowHeight = 32.0;
  static const sidebarIconExtent = 16.0;
  static const sidebarRowInset = 12.0;
  static const sidebarGap = 8.0;
  static const sidebarRowSpacing = 4.0;
  static const sidebarCorner = 6.0;
  static const sidebarFontSize = 13.0;
  static const sidebarBrandFontSize = 18.0;
  static const sidebarSloganFontSize = 11.0;
  static const sidebarBrandLineGap = 2.0;
  static const sidebarRowPadding = EdgeInsets.fromLTRB(sidebarRowInset,0,sidebarRowInset,sidebarRowSpacing);
  static EdgeInsets sidebarHeaderPadding(bool collapsed) => EdgeInsets.symmetric(horizontal:collapsed?0:sidebarHeaderInset);
  static TextStyle? sidebarTextStyle(ThemeData theme,{required String family,required double scale,required Color color,bool brand=false,bool slogan=false,bool selected=false}) {
    final source=slogan?theme.textTheme.bodySmall:brand?theme.textTheme.titleSmall:theme.textTheme.bodyMedium;
    return source?.copyWith(fontFamily:family=='system'?PrimeThemeCenterStyle.fontFamily:family,fontSize:(slogan?sidebarSloganFontSize:brand?sidebarBrandFontSize:sidebarFontSize)*scale,height:1,
      fontWeight:brand?FontWeight.w700:selected?FontWeight.w600:FontWeight.normal,color:color);
  }
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
