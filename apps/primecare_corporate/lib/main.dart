import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inject the UI implementation into the Core Registry to prevent circular package cycles
  ScreenRegistry.setDynamicDashboardBuilder((context, role) => DynamicRoleDashboardScreen(role: role));

  await EasyLocalization.ensureInitialized();
  
  final sharedPreferences = await SharedPreferences.getInstance();
  
      runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
        // Use the resolved package path that matches the web server directory structure
        path: 'assets/translations', 
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          ],
          child: const PrimeCareCorporateApp(),
        ),
      ),
    );
  });
}

class PrimeCareCorporateApp extends ConsumerWidget {
  const PrimeCareCorporateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare Corporate',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}
