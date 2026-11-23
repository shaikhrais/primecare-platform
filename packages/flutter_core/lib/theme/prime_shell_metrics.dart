import 'package:flutter/material.dart';
import 'prime_theme_center_style.dart';

/// Reference src/styles/index.css overrides md to 60rem (960px).
/// ToolbarLayout1/2 and FooterLayout1/2 use min-h-12 md:min-h-16.
abstract final class PrimeShellMetrics {
  static const desktopBreakpoint = 960.0;
  static const horizontalContentWidth = 1120.0;
  static const horizontalDesktopBreakpoint = 1280.0;
  static const horizontalChromeInset = EdgeInsets.symmetric(horizontal: 32);
  static const horizontalNavigationPadding = EdgeInsets.symmetric(horizontal: 16);
  static const horizontalNavigationItemPadding = EdgeInsets.symmetric(horizontal: 4);
  static BoxDecoration horizontalNavigationDecoration(
    ThemeData theme, {
    required Color background,
    Color? divider,
  }) => BoxDecoration(
    color: background,
    border: Border(
      bottom: BorderSide(color: divider ?? theme.dividerColor.withValues(alpha: 0.1)),
    ),
  );

  static const horizontalNavbarHeight = 64.0;
  static const horizontalNavigationRowHeight = 48.0;
  static const horizontalDestinationPaintHeight = 36.0;
  static const expandedNavigationWidth = 280;
  // The persisted profile continues to use 64 as its folded marker.
  static const foldedNavigationMarker = 64;
  static const foldedNavigationWidth = 48.0;
  static const mobileDrawerWidth = 280.0;
  static const sidebarToggleSize = 32.0;
  static const sidebarToggleOutlineSize = 28.0;
  static BoxDecoration sidebarToggleDecoration(ThemeData theme) => BoxDecoration(
    border: Border.all(color: theme.colorScheme.outlineVariant),
    borderRadius: navigationItemRadius,
  );
  static const foldedHeaderExtent = 56.0;
  static const foldedNavigationTopGap = 4.0;
  static const foldedRowPadding = EdgeInsets.fromLTRB(8, 0, 8, 4);
  static EdgeInsets sidebarRowContentPadding(bool folded) => folded
      ? EdgeInsets.zero
      : const EdgeInsets.symmetric(horizontal: sidebarGap);

  static Color sidebarSelectionFill({
    required Color background,
    required Color foreground,
    required Brightness brightness,
  }) => Color.alphaBlend(
    foreground.withValues(alpha: brightness == Brightness.dark ? 0.10 : 0.05),
    background,
  );

  static Color navigationHoverInk(Color contrastInk) =>
      contrastInk.withValues(alpha: 0.06);

  static Color navigationFocusInk(Color contrastInk) =>
      contrastInk.withValues(alpha: 0.12);

  static ButtonStyle horizontalDestinationStyle({
    required Color foreground,
    required Color? selectedBackground,
  }) => ButtonStyle(
    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
    minimumSize: const WidgetStatePropertyAll(
      Size(0, horizontalDestinationPaintHeight),
    ),
    fixedSize: const WidgetStatePropertyAll(
      Size.fromHeight(horizontalDestinationPaintHeight),
    ),
    tapTargetSize: MaterialTapTargetSize.padded,
    shape: const WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: navigationItemRadius),
    ),
    backgroundColor: WidgetStatePropertyAll(selectedBackground),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.focused)) {
        return navigationFocusInk(foreground);
      }
      if (states.contains(WidgetState.hovered)) {
        return navigationHoverInk(foreground);
      }
      return null;
    }),
  );

  static ThemeData navigationInteractionTheme(
    ThemeData theme,
    Color contrastInk,
  ) => theme.copyWith(
    hoverColor: navigationHoverInk(contrastInk),
    focusColor: navigationFocusInk(contrastInk),
  );

  static BoxDecoration sidebarDecoration({
    required Color background,
    required Color divider,
    required bool onTrailingSide,
    required TextDirection direction,
  }) {
    final border = BorderSide(color: divider);
    final borderOnRight = onTrailingSide == (direction == TextDirection.rtl);
    return BoxDecoration(
      color: background,
      border: borderOnRight ? Border(right: border) : Border(left: border),
    );
  }

  static const dividerExtent = 1.0;
  static const sidebarHeaderInset = 20.0;
  static const sidebarLogoExtent = 24.0;
  static const sidebarRowHeight = 32.0;
  static const sidebarIconExtent = 16.0;
  static const sidebarRowInset = 12.0;
  static const sidebarGap = 8.0;
  static const sidebarRowSpacing = 4.0;
  static const sidebarCorner = 6.0;
  static const navigationItemRadius = BorderRadius.all(Radius.circular(sidebarCorner));
  static const sidebarFontSize = 13.0;
  static const sidebarBrandFontSize = 18.0;
  static const sidebarSloganFontSize = 11.0;
  static const sidebarBrandLineGap = 2.0;
  static const sidebarRowPadding = EdgeInsets.fromLTRB(sidebarRowInset,0,sidebarRowInset,sidebarRowSpacing);
  static EdgeInsets sidebarHeaderPadding(bool collapsed) => EdgeInsets.symmetric(horizontal:collapsed?0:sidebarHeaderInset);
  static TextStyle? sidebarTextStyle(ThemeData theme,{required String family,required double scale,required Color color,bool brand=false,bool slogan=false,bool selected=false}) {
    final source=slogan?theme.textTheme.bodySmall:brand?theme.textTheme.titleSmall:theme.textTheme.bodyMedium;
    return source?.copyWith(fontFamily:family=='system'?PrimeThemeCenterStyle.fontFamily:family,fontSize:(slogan?sidebarSloganFontSize:brand?sidebarBrandFontSize:sidebarFontSize)*scale,height:1,
      fontWeight:brand?FontWeight.w700:selected?FontWeight.w500:FontWeight.normal,color:color);
  }
  static double barHeight(double viewportWidth) => viewportWidth >= desktopBreakpoint ? 64 : 48;
  static double toolbarExtent(double width, {required bool horizontal}) => barHeight(width)+(horizontal?dividerExtent:0);
  static double footerExtent(double width) => barHeight(width)+dividerExtent;
}

/// Keeps horizontal bars full bleed and aligns their controls to one column.
class PrimeHorizontalChrome extends StatelessWidget {
  final Color background;
  final Widget child;
  const PrimeHorizontalChrome({
    super.key,
    required this.background,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.sizeOf(context).width >=
        PrimeShellMetrics.horizontalDesktopBreakpoint;
    return ColoredBox(
      color: background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: PrimeShellMetrics.horizontalContentWidth,
          ),
          child: Padding(
            padding: desktop ? PrimeShellMetrics.horizontalChromeInset : EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
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
