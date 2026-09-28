import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'client_routes.dart';

final clientApplicationProvider = Provider<ClientApplication>((ref) {
  return ClientApplication();
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
    application: ref.read(clientApplicationProvider),
  );
});
