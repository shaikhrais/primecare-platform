import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import 'app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();
      runApp(const ProviderScope(child: PrimeCareBusinessDevelopmentApp()));
  });
}

class PrimeCareBusinessDevelopmentApp extends ConsumerWidget {
  const PrimeCareBusinessDevelopmentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare BusinessDevelopment',
      routerConfig: router,
    );
  }
}
