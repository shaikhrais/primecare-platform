// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO
import 'package:primecare_ui/primecare_ui.dart';
import 'core/routing/corporate_routes.dart' as corporate;
import 'core/routing/app_router.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/semantics.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }

  PrimeCareAppRunner.run(
    appWidget: const PrimeCareCorporateApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(corporate.CorporateApplication()),
    ],
  );
}

class PrimeCareCorporateApp extends ConsumerWidget {
  const PrimeCareCorporateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize Deep Link listener for Native SSO
    ref.read(deepLinkServiceProvider);

    final tenant = corporate.PrimeCareTenant();

    return MaterialApp.router(
      title: 'PrimeCare Corporate Portal',
      theme: tenant.branding,
      routerConfig: ref.watch(appRouterProvider),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
