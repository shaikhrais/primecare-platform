// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO Sync languageProvider with EasyLocalization
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'core/routing/support_routes.dart';
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
    appWidget: const PrimeCareSupportApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(SupportApplication()),
    ],
  );
}

class PrimeCareSupportApp extends BaseStandardPrimeCareApp {
  const PrimeCareSupportApp({super.key});
  @override
  String get applicationTitle => 'PrimeCare Support';
  @override
  GoRouter routerFor(WidgetRef ref) => ref.watch(appRouterProvider);
}
