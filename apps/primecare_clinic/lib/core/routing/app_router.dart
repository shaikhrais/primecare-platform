import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinic_routes.dart';

final clinicApplicationProvider = Provider<ClinicApplication>((ref) {
  return ClinicApplication();
});

final activeRoleProvider = Provider<PlatformRole>((ref) {
  final authState = ref.watch(authProvider);
  if (!authState.isInitialized || !authState.isAuthenticated) {
    return PlatformRole.guest;
  }
  return PlatformRole.fromName(authState.role);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  return SharedAuthRouter.build(
    ref: ref,
    activeRole: ref.watch(activeRoleProvider),
    application: ref.read(clinicApplicationProvider),
    additionalPublicRoutes: [
      GoRoute(path: CommonRoutes.globalSettings,
        builder: (context, state) => const AppShellBoundary(child: GlobalSettingsScreen())),
    ],
  );
});
