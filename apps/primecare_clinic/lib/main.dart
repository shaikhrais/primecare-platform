// Governance - Category: service | Purpose: Initialize Deep Link listener for Native SSO
import 'package:primecare_ui/primecare_ui.dart';
import 'core/routing/clinic_routes.dart';
import 'core/routing/app_router.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/semantics.dart';

void main() {
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
    // Initialize Deep Link listener for Native SSO
    ref.read(deepLinkServiceProvider);
    
    // Sync languageProvider with EasyLocalization
    final langCode = ref.watch(languageProvider);
    if (context.locale.languageCode != langCode) {
      Future.microtask(() => context.setLocale(Locale(langCode)));
    }

    final tenant = ClinicTenant();

    return MaterialApp.router(
      title: 'PrimeCare Clinic Portal',
      theme: tenant.branding,
      routerConfig: ref.watch(appRouterProvider),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
