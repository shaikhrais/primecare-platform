// Host retains its authenticated role binding.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_screen_models/models/navigation_item.dart';
import 'package:primecare_portal_state/portal_providers.dart';
import '../auth_service.dart';
export 'package:primecare_portal_state/portal_providers.dart' hide buildNavigationMenu, buildPortalConfig;

final navigationMenuProvider = Provider<List<PrimeCareNavigationItem>>((ref) {
  final authState = ref.watch(authProvider);
  return buildNavigationMenu(ref, authState.role ?? 'PSW');
});

final portalConfigProvider = Provider<PortalConfig>((ref) {
  final authState = ref.watch(authProvider);
  return buildPortalConfig(authState.role ?? 'PSW');
});
