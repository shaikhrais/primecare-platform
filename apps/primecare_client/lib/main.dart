import 'package:flutter_core/primecare_core.dart';
import 'app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const ProviderScope(child: PrimeCareClientApp()));
  });
}

class PrimeCareClientApp extends ConsumerWidget {
  const PrimeCareClientApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(title: 'PrimeCare Client', routerConfig: router);
  }
}
