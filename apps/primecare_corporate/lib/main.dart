import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/foundation.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    AppErrorBoundary.onReset = () {
      debugPrint('PRIMECARE_RECOVERY: 🛠️ Critical failure detected. Initiating Mechanical Fix...');
      
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
         debugPrint('PRIMECARE_RECOVERY: Web state invalidated. Reloading recommended.');
      }
    };

    await EasyLocalization.ensureInitialized();
    final sharedPreferences = await SharedPreferences.getInstance();
    
    // Explicitly hydrate offline data integrity before proceeding
    // Errors are logged internally by the Logistics Hub
    await DataLogisticsHub.ensureOfflineDataLoaded();

    runApp(
      RestartWrapper(
        key: _rootKey,
        child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
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
      ),
    );
  });
}

final GlobalKey _rootKey = GlobalKey();

class PrimeCareCorporateApp extends ConsumerWidget {
  const PrimeCareCorporateApp({super.key});

  static bool _auditPerformed = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telemetry = ref.read(executionGateProvider);
    AppErrorBoundary.drainToTelemetry(telemetry);
    
    // Perform Structural Integrity Audit during boot
    if (!_auditPerformed) {
      _auditPerformed = true;
      try {
        final audit = PlatformGovernanceAudit.performAudit(ref);
      if (audit.blueprintAudit.any((b) => !b.isCompliant)) {
        telemetry.failGate(
          ExecutionGateCategory.structuralIntegrity,
          'Structural Mismatch Detected: ${audit.blueprintAudit.where((b) => !b.isCompliant).length} failures',
          metadata: {'audit_summary': audit.toString()},
        );
      } else {
        telemetry.passGate(
          ExecutionGateCategory.structuralIntegrity,
          'Full Platform Structural Compliance Confirmed',
        );
      }
    } catch (e, stack) {
      telemetry.failGate(
        ExecutionGateCategory.governance,
        'Platform Governance Audit Failed to Execute',
        error: e,
        stackTrace: stack,
      );
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
