// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'core/routing/corporate_routes.dart' as corporate;
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
    appWidget: const PrimeCareCorporateApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(
        corporate.CorporateApplication(),
      ),
    ],
  );
}

class PrimeCareCorporateApp extends BasePrimeCareApp {
  const PrimeCareCorporateApp({super.key});
  @override
  String get applicationTitle => 'PrimeCare Corporate Portal';
  @override
  GoRouter routerFor(WidgetRef ref) => ref.watch(appRouterProvider);
  @override
  ThemeData get applicationTheme => corporate.PrimeCareTenant().branding;
}
