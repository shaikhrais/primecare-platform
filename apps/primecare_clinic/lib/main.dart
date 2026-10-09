// Governance - Category: service | Purpose: Initialize the clinic app with shared authentication
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'core/routing/clinic_routes.dart';
import 'core/routing/app_router.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/semantics.dart';

void main() {
  configureUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }

  PrimeCareAppRunner.run(
    appWidget: const PrimeCareClinicApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(ClinicApplication()),
    ],
  );
}

class PrimeCareClinicApp extends BaseThemedPrimeCareApp {
  const PrimeCareClinicApp({super.key});
  @override
  String get applicationTitle => 'PrimeCare Clinic Portal';
  @override
  GoRouter routerFor(WidgetRef ref) => ref.watch(appRouterProvider);
  @override
  PrimeThemeData get primeTheme => ClinicTenant().primeThemeData;
  @override
  bool get useShellBoundary => false;
}
