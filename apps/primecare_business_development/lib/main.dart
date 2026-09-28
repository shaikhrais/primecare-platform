// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO Sync languageProvider with EasyLocalization
import 'package:primecare_ui/primecare_ui.dart';
import 'core/routing/business_development_routes.dart';
import 'core/routing/app_router.dart';

void main() {
  configureUrlStrategy();
  PrimeCareAppRunner.run(
    appWidget: const PrimeCareBusinessDevelopmentApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(BusinessDevelopmentApplication()),
    ],
  );
}

class PrimeCareBusinessDevelopmentApp extends ConsumerWidget {
  const PrimeCareBusinessDevelopmentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));


    final router = ref.watch(appRouterProvider);
    const primeTheme = PrimeThemeData();

    return AppShellBoundary(
      child: PrimeTheme(
        data: primeTheme,
        child: MaterialApp.router(
          title: 'PrimeCare BusinessDevelopment',
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
