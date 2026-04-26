import 'package:flutter_core/primecare_core.dart';
import 'app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
        path: 'packages/flutter_core/assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: const ProviderScope(child: PrimeCareBusinessDevelopmentApp()),
      ),
    );
  });
}

class PrimeCareBusinessDevelopmentApp extends ConsumerWidget {
  const PrimeCareBusinessDevelopmentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));

    // Sync languageProvider with EasyLocalization
    final langCode = ref.watch(languageProvider);
    if (context.locale.languageCode != langCode) {
      Future.microtask(() => context.setLocale(Locale(langCode)));
    }

    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare BusinessDevelopment',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}
