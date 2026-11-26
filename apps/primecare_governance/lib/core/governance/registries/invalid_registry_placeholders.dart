import 'dart:convert';
import 'package:flutter_core/flutter_core.dart';

/// Exact legacy non-screen records with no title, route, roles or renderer.
/// Retiring these executable declarations does not verify or delete their data.
class InvalidRegistryPlaceholders {
  static const ids = <String>{
    'SCREEN_REGIONAL_MANAGER_LABELS', 'SCREEN_CLINICAL_DIRECTOR_LABELS',
    'SCREEN_COMMAND_CENTER_LABELS', 'SCREEN_CTO_DASHBOARD_LABELS',
    'SCREEN_CEO_DASHBOARD_LABELS', 'SCREEN_CLINICAL_LABELS',
    'SCREEN_CFO_DASHBOARD_LABELS', 'SCREEN_SUPPORT_DASHBOARD_LABELS',
    'SCREEN_MARKETING_DASHBOARD_LABELS',
  };

  static bool matches(ScreenMetadata record) {
    if (!ids.contains(record.id)) return false;
    final original = ScreenMetadata(id: record.id, title: '', featureName: '',
      routePath: '', allowedRoles: const [], icon: Icons.auto_awesome_outlined,
      lifecycleStatus: LifecycleStatus.design,
      designSize: const PlatformSize(3840, 2160),
      sourcePath: 'packages/primecare_ui/lib/src/registry/screen_registry.dart',
      isRenderOk: false, userApprovedLayout: false, testPassRate: 0,
      lastVerificationHash: 'HASH_PENDING', uatApprover: 'none');
    return record.icon == original.icon &&
        jsonEncode(record.toJson()) == jsonEncode(original.toJson());
  }
}
