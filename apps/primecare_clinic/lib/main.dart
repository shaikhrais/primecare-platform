import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/routing/clinic_routes.dart';
import 'core/routing/app_router.dart';



void main() {
  PrimeCareAppRunner.run(
    appWidget: const PrimeCareClinicApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(ClinicApplication()),
    ],
  );
}

class PrimeCareClinicApp extends ConsumerWidget {
  const PrimeCareClinicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));

    // Sync languageProvider with EasyLocalization
    final langCode = ref.watch(languageProvider);
    if (context.locale.languageCode != langCode) {
      Future.microtask(() => context.setLocale(Locale(langCode)));
    }

    final router = ref.watch(appRouterProvider);
    const primeTheme = PrimeThemeData();

    return PrimeTheme(
      data: primeTheme,
      child: MaterialApp.router(
        title: 'PrimeCare Clinic',
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
