class PermissionRegistry {
  // Simplified for demonstration. In production, this would be more granular.
  static bool hasPermission(String userRole, List<String> allowedRoles) {
    if (userRole == 'superuser') return true;
    return allowedRoles.contains(userRole);
  }

  static bool canAccessScreen(
    String userRole,
    String screenId,
    Map<String, dynamic> screenMetadata,
  ) {
    final allowedRoles = screenMetadata['allowedRoles'] as List<String>? ?? [];
    return hasPermission(userRole, allowedRoles);
  }
}
