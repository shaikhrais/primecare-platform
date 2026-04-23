import 'package:primecare_ui/primecare_ui.dart';
import 'app_router.dart';

void main() {
  AppErrorBoundary.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(const ProviderScope(child: PrimeCareFranchiseApp()));
  });
}

class PrimeCareFranchiseApp extends ConsumerWidget {
  const PrimeCareFranchiseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare Franchise',
      routerConfig: router,
    );
  }
}
