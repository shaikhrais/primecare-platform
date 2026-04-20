import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

      runApp(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const PrimeCareClinicApp(),
      ),
    );
  });
}

class PrimeCareClinicApp extends ConsumerWidget {
  const PrimeCareClinicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(title: 'PrimeCare Clinic', routerConfig: router);
  }
}
