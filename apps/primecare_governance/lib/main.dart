// Governance - Category: service | Purpose: 1. Initialize Security Governance Watchdog (Bank-Grade) 2. Perform Environment Integrity Audit 3. Initialize and regi...
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide languageProvider;
import 'core/governance/route_registry.dart';
import 'core/i18n/language_provider.dart';

import 'core/routing/governance_application.dart';
import 'core/governance/registries/index.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/semantics.dart';

void main() async {
  configureUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }

  // 1. Initialize Security Governance Watchdog (Bank-Grade)
  SessionWatchdog.instance.initialize();

  // 2. Perform Environment Integrity Audit
  await AppIntegrityService.instance.checkIntegrity();

  // 3. Initialize and register all governance screens
  Registry.registerAll();
  debugPrint('Registry Hydrated: ${Registry.getAllScreens().length} screens registered.');

  PrimeCareAppRunner.run(
    appWidget: const PrimeCareApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(GovernanceApplication()),
    ],
  );
}

class PrimeCareApp extends ConsumerWidget {
  const PrimeCareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    const primeTheme = PrimeThemeData();

    return AppShellBoundary(
      child: PrimeTheme(
        data: primeTheme,
        child: MaterialApp.router(
          title: 'PrimeCare Enterprise',
          theme: primeTheme.toThemeData(),
          themeMode: ThemeMode.light,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: ref.watch(appRouterProvider),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
