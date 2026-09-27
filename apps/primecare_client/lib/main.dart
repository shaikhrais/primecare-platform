// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO Sync languageProvider with EasyLocalization
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
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

class PrimeCareClientApp extends ConsumerWidget {
  const PrimeCareClientApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));

    // Initialize Deep Link listener for Native SSO
    ref.read(deepLinkServiceProvider);

    final router = ref.watch(appRouterProvider);
    const primeTheme = PrimeThemeData();

    return AppShellBoundary(
      child: PrimeTheme(
        data: primeTheme,
        child: MaterialApp.router(
          title: 'PrimeCare Client',
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
