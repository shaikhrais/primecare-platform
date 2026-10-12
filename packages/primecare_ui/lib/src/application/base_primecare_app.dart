import 'package:flutter_core/theme/app_theme.dart' show GovernanceThemeColors;
import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart'
    show AppErrorBoundary, executionGateProvider, AppShellBoundary;
import 'package:go_router/go_router.dart';
import '../theme/prime_theme.dart';

/// One root build lifecycle; products supply their router and branding.
abstract class BasePrimeCareApp extends ConsumerWidget {
  const BasePrimeCareApp({super.key});

  String get applicationTitle;
  GoRouter routerFor(WidgetRef ref);
  ThemeData get applicationTheme;
  ThemeMode get applicationThemeMode => ThemeMode.system;
  bool get useShellBoundary => true;
  bool get drainTelemetry => false;
  Widget decorateApplication(Widget child) => child;
  Widget decorateResolvedApplication(Widget child,ThemeData theme,PersonalTheme? personal) {
    if (personal == null) return decorateApplication(child);
    return PrimeTheme(data:resolvePersonalPrimeTheme(const PrimeThemeData(),theme,personal),child:decorateApplication(child));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (drainTelemetry) {
      AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    }
    final router = routerFor(ref);
    final personal=ref.watch(themeSettingsProvider).personalTheme;
    final resolvedTheme=personal==null?applicationTheme:applyPersonalThemeData(applicationTheme,personal);
    final app = MaterialApp.router(
      title: applicationTitle,
      debugShowCheckedModeBanner: false,
      theme: resolvedTheme,
      themeMode: applicationThemeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
    final decorated = decorateResolvedApplication(app,resolvedTheme,personal);
    return useShellBoundary ? AppShellBoundary(child: decorated) : decorated;
  }
}

/// Product roots that expose the existing PrimeTheme inherited widget.
abstract class BaseThemedPrimeCareApp extends BasePrimeCareApp {
  const BaseThemedPrimeCareApp({super.key});
  PrimeThemeData get primeTheme => const PrimeThemeData();
  @override
  ThemeData get applicationTheme => primeTheme.toThemeData();
  @override
  Widget decorateApplication(Widget child) =>
      PrimeTheme(data: primeTheme, child: child);
  @override
  Widget decorateResolvedApplication(Widget child,ThemeData theme,PersonalTheme? personal) {
    if(personal==null)return decorateApplication(child);
    return PrimeTheme(data:resolvePersonalPrimeTheme(primeTheme,theme,personal),child:child);
  }
}

/// Existing shared policy for client/support/franchise/marketing/BDM roots.
abstract class BaseStandardPrimeCareApp extends BaseThemedPrimeCareApp {
  const BaseStandardPrimeCareApp({super.key});
  @override
  bool get drainTelemetry => true;
}

PrimeThemeData resolvePersonalPrimeTheme(PrimeThemeData base,ThemeData theme,PersonalTheme personal) {
  final chrome=theme.extension<GovernanceThemeColors>();
  return PrimeThemeData(colors:base.colors.copyWith(primary:theme.colorScheme.primary,onPrimary:theme.colorScheme.onPrimary,primaryContainer:theme.colorScheme.primaryContainer,secondary:theme.colorScheme.secondary,background:theme.scaffoldBackgroundColor,dashboardBackground:theme.scaffoldBackgroundColor,surface:theme.colorScheme.surface,onSurface:theme.colorScheme.onSurface,onSurfaceVariant:theme.colorScheme.onSurfaceVariant,textSecondary:theme.hintColor,surfaceContainer:theme.colorScheme.surface,surfaceContainerLow:theme.colorScheme.surface,surfaceContainerHigh:theme.colorScheme.surface,surfaceContainerLowest:theme.colorScheme.surface,surfaceContainerHighest:theme.colorScheme.surface,sidebarBackground:chrome?.sidebarBackground,topbarBackground:chrome?.topbarBackground,sidebarTextColor:chrome?.sidebarTextColor,sidebarSelectedTextColor:chrome?.sidebarSelectedTextColor,sidebarIconColor:chrome?.sidebarIconColor,sidebarSelectedIconColor:chrome?.sidebarSelectedIconColor,sidebarSelectedTileColor:chrome?.sidebarSelectedTileColor,sidebarDividerColor:chrome?.sidebarDividerColor,topbarTextColor:chrome?.topbarTextColor,topbarSelectedTextColor:chrome?.topbarSelectedTextColor,topbarIconColor:chrome?.topbarIconColor,topbarSelectedIconColor:chrome?.topbarSelectedIconColor,topbarDividerColor:chrome?.topbarDividerColor,outline:theme.colorScheme.outline,border:theme.colorScheme.outline,divider:theme.dividerColor),typography:RuntimePrimeTypography(base.typography,personal,theme.colorScheme.onSurface),spacing:base.spacing,radiusXs:personal.radius.toDouble(),radiusSm:personal.radius.toDouble(),radiusDefault:personal.radius.toDouble(),radiusMd:personal.radius.toDouble(),radiusLg:personal.radius.toDouble(),radiusXl:personal.radius.toDouble(),shadowsSurface1:base.shadowsSurface1,shadowsSurface2:base.shadowsSurface2);
}
