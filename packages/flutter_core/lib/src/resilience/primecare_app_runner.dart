// Governance - Category: service | Purpose: Bootstraps the application with full resilience: BoundaryTelemetryDrain, RestartWrapper, EasyLocalization, and Provid...
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/semantics.dart';
import '../services/device_manager.dart';

import '../../providers/persistence_providers.dart';
import '../localization/language_provider.dart';
import 'app_error_boundary.dart';
import 'mechanical_repair_kit.dart';
import 'restart_wrapper.dart';

final GlobalKey _primeCareRootKey = GlobalKey();

class PrimeCareAppRunner {
  /// Bootstraps the application with full resilience:
  /// BoundaryTelemetryDrain, RestartWrapper, EasyLocalization, and ProviderScope.
  static void run({
    required Widget appWidget,
    List<dynamic> overrides = const [],
  }) {
    AppErrorBoundary.runGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      if (kIsWeb) {
        SemanticsBinding.instance.ensureSemantics();
      }

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
      await DeviceManager.instance.initialize();

      runApp(
        RestartWrapper(
          key: _primeCareRootKey,
          child: EasyLocalization(
            supportedLocales: const [
              Locale('en'),
              Locale('fr'),
              Locale('es'),
            ],
            path: 'assets/translations',
            fallbackLocale: const Locale('en'),
            useOnlyLangCode: true,
            useFallbackTranslations: true,
            child: ProviderScope(
              overrides: [
                sharedPreferencesProvider.overrideWithValue(sharedPreferences),
                ...overrides.cast(),
              ],
              child: BoundaryTelemetryDrain(
                child: LocaleRebuildWrapper(child: appWidget),
              ),
            ),
          ),
        ),
      );
    });
  }
}

/// Synchronizes the persisted preference with the rendered locale, including
/// startup and selections made while a previous locale is still loading.
class LocaleRebuildWrapper extends ConsumerStatefulWidget {
  final Widget child;
  const LocaleRebuildWrapper({super.key, required this.child});
  @override
  ConsumerState<LocaleRebuildWrapper> createState() => _LocaleRebuildWrapperState();
}

class _LocaleRebuildWrapperState extends ConsumerState<LocaleRebuildWrapper> {
  bool _syncing = false;

  @override
  Widget build(BuildContext context) {
    final target = ref.watch(languageProvider);
    if (!_syncing && context.locale.languageCode != target) {
      _syncing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _syncLocale());
    }
    return widget.child;
  }

  Future<void> _syncLocale() async {
    try {
      if (!mounted) return;
      await context.setLocale(Locale(ref.read(languageProvider)));
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }
}
