import 'package:primecare_ui/primecare_ui.dart';
import 'core/routing/app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: const ProviderScope(child: PrimeCareSupportApp()),
      ),
    );
  });
}

class PrimeCareSupportApp extends ConsumerWidget {
  const PrimeCareSupportApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));

    // Sync languageProvider with EasyLocalization
    final langCode = ref.watch(languageProvider);
    if (context.locale.languageCode != langCode) {
      Future.microtask(() => context.setLocale(Locale(langCode)));
    }

    final router = ref.watch(appRouterProvider);
    const primeTheme = PrimeThemeData();

    return PrimeTheme(
      data: primeTheme,
      child: MaterialApp.router(
        title: 'PrimeCare Support',
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
