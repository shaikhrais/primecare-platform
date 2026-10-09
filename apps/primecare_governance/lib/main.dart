// Governance - Category: service | Purpose: 1. Initialize Security Governance Watchdog (Bank-Grade) 2. Perform Environment Integrity Audit 3. Initialize and regi...
import 'package:primecare_ui/primecare_ui.dart' hide languageProvider;
import 'core/governance/route_registry.dart';

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
  debugPrint(
    'Registry Hydrated: ${Registry.getAllScreens().length} screens registered.',
  );

  PrimeCareAppRunner.run(
    appWidget: const PrimeCareApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(GovernanceApplication()),
    ],
  );
}

class PrimeCareApp extends BaseThemedPrimeCareApp {
  const PrimeCareApp({super.key});
  @override
  String get applicationTitle => 'PrimeCare Enterprise';
  @override
  GoRouter routerFor(WidgetRef ref) => ref.watch(appRouterProvider);
  @override
  ThemeMode get applicationThemeMode => ThemeMode.light;
}
