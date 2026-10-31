import 'package:flutter_core/src/localization/live_screen_text.dart';
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
import '../theme/primecare_theme.dart';
import '../theme/prime_theme_resolver.dart';
export '../theme/prime_theme_resolver.dart' show resolvePersonalPrimeTheme;

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
      builder: (context, child) => LiveScreenTextScope(child: child ?? const SizedBox.shrink()),
    );
    final decorated = decorateResolvedApplication(app,resolvedTheme,personal);
    return useShellBoundary ? AppShellBoundary(child: decorated) : decorated;
  }
}

/// Product roots that expose the existing PrimeTheme inherited widget.
abstract class BaseThemedPrimeCareApp extends BasePrimeCareApp {
  const BaseThemedPrimeCareApp({super.key});
  PrimeThemeData get primeTheme => PrimeCareTheme.resolve();
  @override
  ThemeData get applicationTheme => applyPersonalThemeData(primeTheme.toThemeData(), PrimeCareTheme.defaultProfile);
  @override
  Widget decorateApplication(Widget child) =>
      PrimeTheme(data: resolvePersonalPrimeTheme(primeTheme, applicationTheme, PrimeCareTheme.defaultProfile), child: child);
  @override
  Widget decorateResolvedApplication(Widget child,ThemeData theme,PersonalTheme? personal) {
    return PrimeTheme(data:resolvePersonalPrimeTheme(primeTheme,theme,personal ?? PrimeCareTheme.defaultProfile),child:child);
  }
}

/// Existing shared policy for client/support/franchise/marketing/BDM roots.
abstract class BaseStandardPrimeCareApp extends BaseThemedPrimeCareApp {
  const BaseStandardPrimeCareApp({super.key});
  @override
  bool get drainTelemetry => true;
}
