import 'package:primecare_ui/primecare_ui.dart';
// Triggering hot reload to refresh assets.
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_driver/driver_extension.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';

void main() {
  enableFlutterDriverExtension();
  AppErrorBoundary.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    AppErrorBoundary.onReset = () {
      debugPrint(
        'PRIMECARE_RECOVERY: 🛠️ Critical failure detected. Initiating Mechanical Fix...',
      );

      MechanicalRepairKit.performDeepFlush(
        onCustomFlush: () {
          // Flush the UI component registry
          ComponentWarehouse.flush();
        },
      );

      // Trigger a mechanical reboot of the widget tree
      final context = _rootKey.currentContext;
      if (context != null) {
        RestartWrapper.restartApp(context);
      }

      if (kIsWeb) {
        debugPrint(
          'PRIMECARE_RECOVERY: Web state invalidated. Reloading recommended.',
        );
      }
    };

    await EasyLocalization.ensureInitialized();
    final sharedPreferences = await SharedPreferences.getInstance();

    // Explicitly hydrate offline data integrity before proceeding
    // Errors are logged internally by the Logistics Hub
    await DataLogisticsHub.ensureOfflineDataLoaded();

    // Bootstrap Governance Registry early for structural integrity
    GovernanceBootstrapper.bootstrap();

    runApp(
      RestartWrapper(
        key: _rootKey,
        child: EasyLocalization(
          supportedLocales: const [
            Locale('en'),
            Locale('fr'),
            Locale('es'),
            Locale('ar'),
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          useOnlyLangCode: true,
          child: ProviderScope(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(sharedPreferences),
            ],
            child: const BoundaryTelemetryDrain(child: PrimeCareCorporateApp()),
          ),
        ),
      ),
    );
  });
}

final GlobalKey _rootKey = GlobalKey();

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
    return MaterialApp.router(
      title: 'PrimeCare Corporate',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}

