import 'package:flutter_core/primecare_core.dart';
import 'app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const ProviderScope(child: PrimeCareMarketingApp()));
  });
}

class PrimeCareMarketingApp extends ConsumerWidget {
  const PrimeCareMarketingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare Marketing',
      routerConfig: router,
    );
  }
}
