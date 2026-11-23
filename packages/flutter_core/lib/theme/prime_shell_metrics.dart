import 'package:flutter/material.dart';
import 'prime_theme_center_style.dart';

/// Reference src/styles/index.css overrides md to 60rem (960px).
/// ToolbarLayout1/2 and FooterLayout1/2 use min-h-12 md:min-h-16.
abstract final class PrimeShellMetrics {
  static const transparentInteractionInk = Colors.transparent;
  static const _flagWhite = Colors.white;
  static const _flagUsNavy = Color(0xff3c3b6e);
  static const _flagUsRed = Color(0xffb22234);
  static const _flagFrenchBlue = Color(0xff0055a4);
  static const _flagFrenchRed = Color(0xffef4135);
  static const _flagSpanishRed = Color(0xffaa151b);
  static const _flagSpanishYellow = Color(0xfff1bf00);
  static Map<String, Color> languageFlagPalette(String language) => switch (language) {
    'fr' => const {'primary': _flagFrenchBlue, 'accent': _flagFrenchRed, 'onPrimary': _flagWhite},
    'es' => const {'primary': _flagSpanishRed, 'accent': _flagSpanishYellow, 'onPrimary': _flagWhite},
    _ => const {'primary': _flagUsNavy, 'accent': _flagUsRed, 'onPrimary': _flagWhite},
  };
  static const desktopBreakpoint = 960.0;
  static const horizontalContentWidth = 1120.0;
  static const horizontalDesktopBreakpoint = 1280.0;
  static const horizontalChromeInset = EdgeInsets.symmetric(horizontal: 32);
  static const horizontalNavigationPadding = EdgeInsets.symmetric(horizontal: 16);
  static const horizontalNavigationItemPadding = EdgeInsets.zero;
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
  static const horizontalDestinationFontSize = 12.0;
  static const horizontalDestinationLineHeight = 20.0 / 12.0;
  static const horizontalDestinationLetterSpacing = 0.462890625;
  static const expandedNavigationWidth = 280;
  // The persisted profile continues to use 64 as its folded marker.
  static const foldedNavigationMarker = 64;
  static const foldedNavigationWidth = 48.0;
  static const mobileDrawerWidth = 280.0;
  static const sidebarToggleSize = 32.0;
  static const sidebarToggleOutlineSize = 28.0;
  static const toolbarAccountMargin = EdgeInsets.symmetric(vertical: 8);
  static const toolbarAccountPadding = EdgeInsets.fromLTRB(6, 4, 10, 4);
  static const toolbarAccountRadius = BorderRadius.all(Radius.circular(24));
  static const toolbarAccountAvatarRadius = 16.0;
  static BoxDecoration toolbarAccountDecoration(ThemeData theme) => BoxDecoration(
    border: Border.all(color: theme.dividerColor),
    borderRadius: toolbarAccountRadius,
  );
  static TextStyle? toolbarAccountAvatarTextStyle(
    ThemeData theme,
    Color foreground,
  ) => theme.textTheme.labelLarge?.copyWith(
    color: foreground,
    fontWeight: FontWeight.w700,
  );
  static TextStyle? toolbarAccountRoleTextStyle(
    ThemeData theme,
    Color foreground,
  ) => theme.textTheme.labelMedium?.copyWith(
    color: foreground,
    fontWeight: FontWeight.w600,
  );
  static const sidebarAccountGap = 12.0;
  static EdgeInsets sidebarAccountPadding(bool compact) => compact ? const EdgeInsets.symmetric(vertical:16) : const EdgeInsets.fromLTRB(16,16,12,16);
  static BoxDecoration sidebarAccountDecoration(ThemeData theme) => BoxDecoration(border:Border(top:BorderSide(color:theme.dividerColor.withValues(alpha:0.12))));
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
    required Brightness brightness,
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
      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (selectedBackground != null) return selectedBackground;
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.focused)) {
        return brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.05);
      }
      if (states.contains(WidgetState.hovered)) {
        return brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.04);
      }
      return null;
    }),
    // Paint the *current* state above so a held ink highlight does not
    // carry its original alpha into the newly selected destination.
    overlayColor: const WidgetStatePropertyAll(transparentInteractionInk),
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
  static const foldedSidebarCorner = 8.0;
  static const sidebarFocusOutlineWidth = 1.0;
  static const navigationItemRadius = BorderRadius.all(Radius.circular(sidebarCorner));

  static RoundedRectangleBorder sidebarDestinationShape(
    ThemeData theme, {
    required bool folded,
    required bool keyboardFocused,
  }) => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
      folded ? foldedSidebarCorner : sidebarCorner,
    ),
    side: keyboardFocused && !folded
        ? BorderSide(
            color: theme.brightness == Brightness.dark
                ? Colors.white.withValues(alpha: 0.12)
                : const Color(0xffd1d5db),
            width: sidebarFocusOutlineWidth,
          )
        : BorderSide.none,
  );
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
