// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO Sync languageProvider with EasyLocalization
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'core/routing/marketing_routes.dart';
import 'core/routing/app_router.dart';

void main() {
  configureUrlStrategy();
  PrimeCareAppRunner.run(
    appWidget: const PrimeCareMarketingApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(MarketingApplication()),
    ],
  );
}

class PrimeCareMarketingApp extends BaseStandardPrimeCareApp {
  const PrimeCareMarketingApp({super.key});
  @override
  String get applicationTitle => 'PrimeCare Marketing';
  @override
  GoRouter routerFor(WidgetRef ref) => ref.watch(appRouterProvider);
}
