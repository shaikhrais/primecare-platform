import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'personal_theme.dart';
import 'theme_center_theme_data.dart';

/// Four palettes share one settings model; missing sections inherit main.
class PortalSectionThemes extends ThemeExtension<PortalSectionThemes> {
  final Map<String, ThemeData> themes;
  const PortalSectionThemes(this.themes);
  @override PortalSectionThemes copyWith({Map<String, ThemeData>? themes}) => PortalSectionThemes(themes ?? this.themes);
  @override PortalSectionThemes lerp(covariant PortalSectionThemes? other, double t) => t < .5 ? this : other ?? this;
}
ThemeData portalSectionTheme(ThemeData theme, String section) =>
  theme.extension<PortalSectionThemes>()?.themes[section] ?? theme;

ThemeData applyPortalSectionThemes(ThemeData main, Map<String, PersonalTheme> sections) {
  final themes = {for (final entry in sections.entries) entry.key: applyPersonalThemeData(main, entry.value)};
  final colors = main.extension<GovernanceThemeColors>();
  final nav = themes['navbar']?.extension<GovernanceThemeColors>();
  final toolbar = themes['toolbar']?.extension<GovernanceThemeColors>();
  return main.copyWith(extensions: [
    ...main.extensions.values.where((e) => e is! GovernanceThemeColors && e is! PortalSectionThemes),
    if (colors != null) colors.copyWith(
      sidebarBackground: nav?.sidebarBackground,
      sidebarTextColor: nav?.sidebarTextColor,
      sidebarSelectedTextColor: nav?.sidebarSelectedTextColor,
      sidebarIconColor: nav?.sidebarIconColor,
      sidebarSelectedIconColor: nav?.sidebarSelectedIconColor,
      sidebarSelectedTileColor: nav?.sidebarSelectedTileColor,
      sidebarDividerColor: nav?.sidebarDividerColor,
      topbarBackground: toolbar?.topbarBackground,
      topbarTextColor: toolbar?.topbarTextColor,
      topbarIconColor: toolbar?.topbarIconColor,
      topbarSelectedTextColor: toolbar?.topbarSelectedTextColor,
      topbarSelectedIconColor: toolbar?.topbarSelectedIconColor,
      topbarDividerColor: toolbar?.topbarDividerColor),
    PortalSectionThemes(Map.unmodifiable(themes)),
  ]);
}
