import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../providers/persistence_providers.dart';
import 'app_error_boundary.dart';
import 'mechanical_repair_kit.dart';
import 'restart_wrapper.dart';

final GlobalKey _primeCareRootKey = GlobalKey();

class PrimeCareAppRunner {
  /// Bootstraps the application with full resilience:
  /// BoundaryTelemetryDrain, RestartWrapper, EasyLocalization, and ProviderScope.
  static void run({required Widget appWidget}) {
    AppErrorBoundary.runGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      AppErrorBoundary.onReset = () {
        debugPrint(
          'PRIMECARE_RECOVERY: 🛠️ Critical failure detected. Initiating Mechanical Fix...',
        );

        MechanicalRepairKit.performDeepFlush(onCustomFlush: () {});

        final context = _primeCareRootKey.currentContext;
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

      runApp(
        RestartWrapper(
          key: _primeCareRootKey,
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
              child: BoundaryTelemetryDrain(child: appWidget),
            ),
          ),
        ),
      );
    });
  }
}
