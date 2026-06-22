// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO Sync languageProvider with EasyLocalization
import 'package:primecare_ui/primecare_ui.dart';
import 'core/routing/marketing_routes.dart';
import 'core/routing/app_router.dart';

void main() {
  PrimeCareAppRunner.run(
    appWidget: const PrimeCareMarketingApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(MarketingApplication()),
    ],
  );
}

class PrimeCareMarketingApp extends ConsumerWidget {
  const PrimeCareMarketingApp({super.key});

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
          title: 'PrimeCare Marketing',
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
