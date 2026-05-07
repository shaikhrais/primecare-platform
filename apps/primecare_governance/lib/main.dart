import 'package:primecare_ui/primecare_ui.dart' hide languageProvider;
import 'core/governance/route_registry.dart';
import 'core/i18n/language_provider.dart';

import 'dart:ui';
import 'dart:developer' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Handle Flutter-level errors
  FlutterError.onError = (details) {
    dev.log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Handle platform-level/async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    dev.log(error.toString(), stackTrace: stack);
    return true;
  };

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('es'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const ProviderScope(child: PrimeCareApp()),
    ),
  );
}

class PrimeCareApp extends ConsumerWidget {
  const PrimeCareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sync languageProvider with EasyLocalization
    final langCode = ref.watch(languageProvider);
    if (context.locale.languageCode != langCode) {
      Future.microtask(() {
        if (!context.mounted) return;
        context.setLocale(Locale(langCode));
      });
    }

    const primeTheme = PrimeThemeData();

    return PrimeTheme(
      data: primeTheme,
      child: MaterialApp.router(
        title: 'PrimeCare Enterprise',
        theme: primeTheme.toThemeData(),
        themeMode: ThemeMode.light,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: ref.watch(appRouterProvider),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
