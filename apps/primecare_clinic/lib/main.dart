// Governance - Category: service | Purpose: Initialize the clinic app with shared authentication
import 'package:primecare_ui/primecare_ui.dart';
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

class PrimeCareClinicApp extends ConsumerWidget {
  const PrimeCareClinicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenant = ClinicTenant();
    final primeTheme = tenant.primeThemeData;

    return PrimeTheme(
      data: primeTheme,
      child: MaterialApp.router(
        title: 'PrimeCare Clinic Portal',
        theme: primeTheme.toThemeData(),
        routerConfig: ref.watch(appRouterProvider),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
