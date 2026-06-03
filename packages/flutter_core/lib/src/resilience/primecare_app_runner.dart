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

/// A global wrapper that watches [languageProvider] and automatically triggers a smooth
/// fade-out and fade-in transition when the locale changes, avoiding sudden visual jumps/flashes.
class LocaleRebuildWrapper extends ConsumerStatefulWidget {
  final Widget child;
  const LocaleRebuildWrapper({super.key, required this.child});

  @override
  ConsumerState<LocaleRebuildWrapper> createState() => _LocaleRebuildWrapperState();
}

class _LocaleRebuildWrapperState extends ConsumerState<LocaleRebuildWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  String? _activeLangCode;
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final targetLangCode = ref.watch(languageProvider);
    _activeLangCode ??= targetLangCode;

    if (targetLangCode != _activeLangCode && !_isTransitioning) {
      _isTransitioning = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _triggerTransition(targetLangCode);
      });
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }

  Future<void> _triggerTransition(String newLangCode) async {
    // 1. Fade out the entire app
    await _fadeController.forward();

    // 2. Perform global locale switch
    if (mounted) {
      await context.setLocale(Locale(newLangCode));
      setState(() {
        _activeLangCode = newLangCode;
      });
    }

    // 3. Fade the app back in
    await _fadeController.reverse();

    _isTransitioning = false;
  }
}
