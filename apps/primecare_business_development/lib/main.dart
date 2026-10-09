// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO Sync languageProvider with EasyLocalization
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'core/routing/business_development_routes.dart';
import 'core/routing/app_router.dart';

void main() {
  configureUrlStrategy();
  PrimeCareAppRunner.run(
    appWidget: const PrimeCareBusinessDevelopmentApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(
        BusinessDevelopmentApplication(),
      ),
    ],
  );
}

class PrimeCareBusinessDevelopmentApp extends BaseStandardPrimeCareApp {
  const PrimeCareBusinessDevelopmentApp({super.key});
  @override
  String get applicationTitle => 'PrimeCare BusinessDevelopment';
  @override
  GoRouter routerFor(WidgetRef ref) => ref.watch(appRouterProvider);
}
