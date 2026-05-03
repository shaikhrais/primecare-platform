import 'package:primecare_ui/primecare_ui.dart';
import 'core/theme/app_theme.dart' as local_theme;
import 'core/governance/route_registry.dart';

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
      child: const ProviderScope(
        child: PrimeCareApp(),
      ),
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

    return MaterialApp.router(
      title: 'PrimeCare Enterprise',
      theme: local_theme.AppTheme.light,
      darkTheme: local_theme.AppTheme.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: ref.watch(appRouterProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
