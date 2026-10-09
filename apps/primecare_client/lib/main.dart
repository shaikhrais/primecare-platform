// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO Sync languageProvider with EasyLocalization
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'core/routing/client_routes.dart';
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
    appWidget: const PrimeCareClientApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(ClientApplication()),
    ],
  );
}

class PrimeCareClientApp extends BaseStandardPrimeCareApp {
  const PrimeCareClientApp({super.key});
  @override
  String get applicationTitle => 'PrimeCare Client';
  @override
  GoRouter routerFor(WidgetRef ref) => ref.watch(appRouterProvider);
}
