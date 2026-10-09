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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (drainTelemetry) {
      AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    }
    final router = routerFor(ref);
    final app = MaterialApp.router(
      title: applicationTitle,
      debugShowCheckedModeBanner: false,
      theme: applicationTheme,
      themeMode: applicationThemeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
    final decorated = decorateApplication(app);
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
}

/// Existing shared policy for client/support/franchise/marketing/BDM roots.
abstract class BaseStandardPrimeCareApp extends BaseThemedPrimeCareApp {
  const BaseStandardPrimeCareApp({super.key});
  @override
  bool get drainTelemetry => true;
}
