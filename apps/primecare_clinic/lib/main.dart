import 'package:primecare_ui/primecare_ui.dart';
import 'core/routing/clinic_routes.dart';
import 'core/routing/app_router.dart';

void main() {
  PrimeCareAppRunner.run(
    appWidget: const PrimeCareClinicApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(ClinicApplication()),
    ],
  );
}

class PrimeCareClinicApp extends ConsumerWidget {
  const PrimeCareClinicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenant = ClinicTenant();

    return MaterialApp.router(
      title: 'PrimeCare Clinic Portal',
      theme: tenant.branding,
      routerConfig: ref.watch(appRouterProvider),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
