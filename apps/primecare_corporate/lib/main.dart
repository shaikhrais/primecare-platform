import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/routing/corporate_routes.dart';
import 'core/routing/app_router.dart';


void main() {
  PrimeCareAppRunner.run(
    appWidget: const PrimeCareCorporateApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(CorporateApplication()),
    ],
  );
}

class PrimeCareCorporateApp extends ConsumerWidget {
  const PrimeCareCorporateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch languageProvider to sync with EasyLocalization
    final langCode = ref.watch(languageProvider);

    // Sync EasyLocalization if it differs from the provider's state
    // This handles initial load and cross-component updates
    if (context.locale.languageCode != langCode) {
      Future.microtask(() => context.setLocale(Locale(langCode)));
    }

    final router = ref.watch(appRouterProvider);
    const primeTheme = PrimeThemeData();

    return PrimeTheme(
      data: primeTheme,
      child: MaterialApp.router(
        title: 'PrimeCare Corporate',
        debugShowCheckedModeBanner: false,
        theme: primeTheme.toThemeData(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: router,
      ),
    );
  }
}
