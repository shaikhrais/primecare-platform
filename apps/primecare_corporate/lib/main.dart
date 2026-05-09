import 'package:primecare_ui/primecare_ui.dart';
// Triggering hot reload to refresh assets.

import 'core/routing/app_router.dart';

void main() {
  PrimeCareAppRunner.run(appWidget: const PrimeCareCorporateApp());
}

class PrimeCareCorporateApp extends ConsumerWidget {
  const PrimeCareCorporateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch languageProvider to sync with EasyLocalization
    final langCode = ref.watch(languageProvider);

    // Sync EasyLocalization if it differs from the provider's state
    // This handles initial load and cross-component updates
    if (context.locale.languageCode != langCode) {
      Future.microtask(() => context.setLocale(Locale(langCode)));
    }

    final router = ref.watch(appRouterProvider);
    const primeTheme = PrimeThemeData();

    return PrimeTheme(
      data: primeTheme,
      child: MaterialApp.router(
        title: 'PrimeCare Corporate',
        debugShowCheckedModeBanner: false,
        theme: primeTheme.toThemeData(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: router,
      ),
    );
  }
}
