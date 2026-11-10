/// Resolves only exact routes from the authenticated server's visible screens.
/// Presentation catalogs, inventory and role-name similarities are not grants.
/// No grants are cached across navigation or account changes.
Future<String?> authorizeGovernanceRoute({
  required String path,
  required bool landing,
  required String userId,
  required String role,
  required Set<String> availableRoutes,
  required Future<dynamic> Function() loadWorkspace,
  required bool Function() isCurrent,
}) async {
  if (userId.isEmpty || role.isEmpty || !isCurrent()) return null;
  try {
    final data = await loadWorkspace();
    if (!isCurrent() || data is! Map) return null;
    final identity = data['identity'];
    if (identity is! Map || identity['userId'] != userId ||
        identity['role'] != role || data['screens'] is! List) return null;
    final routes = <String>{};
    for (final screen in data['screens'] as List) {
      if (screen is! Map) return null;
      final route = screen['route'];
      if (route is! String || !route.startsWith('/') || route.startsWith('//') ||
          RegExp(r'[?#\\\s]').hasMatch(route) || !routes.add(route)) return null;
    }
    final destination = landing ? data['landing'] : path;
    return destination is String && availableRoutes.contains(destination) &&
        routes.contains(destination) && isCurrent() ? destination : null;
  } catch (_) {
    return null;
  }
}
