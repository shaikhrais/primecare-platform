// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO Sync languageProvider with EasyLocalization
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'core/routing/franchise_routes.dart';
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
    appWidget: const PrimeCareFranchiseApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(FranchiseApplication()),
    ],
  );
}

class PrimeCareFranchiseApp extends ConsumerWidget {
  const PrimeCareFranchiseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));


    final router = ref.watch(appRouterProvider);
    const primeTheme = PrimeThemeData();

    return AppShellBoundary(
      child: PrimeTheme(
        data: primeTheme,
        child: MaterialApp.router(
          title: 'PrimeCare Franchise',
          debugShowCheckedModeBanner: false,
          theme: primeTheme.toThemeData(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: router,
        ),
      ),
    );
  }
}
