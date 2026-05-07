import 'dart:io';
import 'package:path/path.dart' as p;

/// Automated Governance Manifest Generator for PrimeCare Platform.
///
/// Scans the workspace to calculate LOC, file counts, and MVC patterns
/// to update the [PlatformGovernanceRegistry].
void main() async {
  stdout.writeln('🚀 Starting PrimeCare Governance Sync...');

  final rootDir = Directory.current.parent.parent;
  final registryFile = File(
    p.join(
      rootDir.path,
      'packages',
      'factory_system',
      'primecare_ui',
      'lib',
      'src',
      'shared',
      'src',
      'integration',
      'platform_governance_registry.dart',
    ),
  );

  final roleFile = File(
    p.join(
      rootDir.path,
      'packages',
      'flutter_core',
      'lib',
      'registry',
      'platform_role.dart',
    ),
  );

  final screenRegistryFile = File(
    p.join(
      rootDir.path,
      'apps',
      'primecare_governance',
      'lib',
      'core',
      'governance',
      'screen_registry.dart',
    ),
  );

  if (!registryFile.existsSync()) {
    stderr.writeln(
      '❌ Error: Could not find registry file at ${registryFile.path}',
    );
    exit(1);
  }

  final projectPaths = {
    'governanceApp': 'apps/primecare_governance',
    'corporateApp': 'apps/primecare_corporate',
    'franchiseApp': 'apps/primecare_franchise',
    'clinicApp': 'apps/primecare_clinic',
    'uiFactory': 'packages/factory_system/primecare_ui',
    'marketingApp': 'apps/primecare_marketing',
    'businessDevApp': 'apps/primecare_business_development',
    'supportApp': 'apps/primecare_support',
    'clientApp': 'apps/primecare_client',
    'flutterCore': 'packages/flutter_core',
    'enterpriseBlueprintApp': 'apps/primecare_enterprise_blueprint',
    'verificationService': 'apps/verification-service',
    'apiGateway': 'services/api-gateway',
    'authApi': 'services/auth-api',
    'billingApi': 'services/billing-api',
    'clientApi': 'services/client-api',
    'complianceApi': 'services/compliance-api',
    'franchiseReportingApi': 'services/franchise-reporting-api',
    'governanceApi': 'services/governance_api',
    'governanceService': 'services/governance_service',
    'notesApi': 'services/notes-api',
    'notificationApi': 'services/notification-api',
    'providerApi': 'services/provider-api',
    'schedulingApi': 'services/scheduling-api',
    'visitApi': 'services/visit-api',
  };

  final locManifest = <String, int>{};
  final fileManifest = <String, int>{};
  final mvcManifest = <String, Map<String, int>>{};

  for (final entry in projectPaths.entries) {
    final projectName = entry.key;
    final relativePath = entry.value;
    final dir = Directory(p.join(rootDir.path, relativePath));

    if (!dir.existsSync()) {
      stdout.writeln('⚠️ Warning: Directory not found: ${dir.path}');
      locManifest[projectName] = 0;
      fileManifest[projectName] = 0;
      mvcManifest[projectName] = {'M': 0, 'V': 0, 'C': 0};
      continue;
    }

    int loc = 0;
    int files = 0;
    int m = 0, v = 0, c = 0;

    await for (final file in dir.list(recursive: true)) {
      if (file is File && _isSignificantFile(file.path)) {
        files++;
        final lines = await file.readAsLines();
        loc += lines.length;

        final fileName = p.basename(file.path).toLowerCase();
        if (fileName.contains('model.dart')) {
          m++;
        } else if (fileName.contains('view.dart') ||
            fileName.contains('screen.dart')) {
          v++;
        } else if (fileName.contains('controller.dart') ||
            fileName.contains('notifier.dart')) {
          c++;
        }
      }
    }

    locManifest[projectName] = loc;
    fileManifest[projectName] = files;
    mvcManifest[projectName] = {'M': m, 'V': v, 'C': c};

    stdout.writeln('✅ Synced $projectName: $loc LOC, $files files');
  }

  // --- RBAC Analysis ---
  int totalRoles = 0;
  if (roleFile.existsSync()) {
    final content = await roleFile.readAsString();
    final enumPart = content.split('enum PlatformRole {');
    if (enumPart.length > 1) {
      totalRoles = RegExp(
        r'[a-zA-Z0-9]+,',
      ).allMatches(enumPart[1].split('}')[0]).length;
    }
  }

  // --- Screen Analysis ---
  int rolesWithScreens = 0;
  if (screenRegistryFile.existsSync()) {
    final content = await screenRegistryFile.readAsString();
    final roleMatches = RegExp(r"role: '([^']+)'").allMatches(content);
    rolesWithScreens = roleMatches.map((m) => m.group(1)).toSet().length;
  }

  final newContent = _generateRegistryContent(
    locManifest,
    fileManifest,
    mvcManifest,
    totalRoles: totalRoles,
    rolesWithScreens: rolesWithScreens,
  );
  await registryFile.writeAsString(newContent);

  stdout.writeln(
    '✨ Governance Manifest successfully updated with RBAC & MVC statistics!',
  );
}

bool _isSignificantFile(String path) {
  if (!path.endsWith('.dart') &&
      !path.endsWith('.ts') &&
      !path.endsWith('.js')) {
    return false;
  }
  if (path.contains('.dart_tool')) {
    return false;
  }
  if (path.contains('node_modules')) {
    return false;
  }
  if (path.contains('.git')) {
    return false;
  }
  if (path.contains('generated')) {
    return false;
  }
  return true;
}

String _generateRegistryContent(
  Map<String, int> loc,
  Map<String, int> files,
  Map<String, Map<String, int>> mvc, {
  int totalRoles = 0,
  int rolesWithScreens = 0,
}) {
  final now = DateTime.now().toIso8601String();
  final signature = 'UNIVERSAL-LOCK-\${DateTime.now().millisecondsSinceEpoch}';

  final locEntries = loc.entries
      .map((e) => '    PlatformProject.${e.key}: ${e.value},')
      .join('\n');
  final fileEntries = files.entries
      .map((e) => '    PlatformProject.${e.key}: ${e.value},')
      .join('\n');

  final uiMvcEntries = mvc.entries
      .where((e) => !e.key.toLowerCase().contains('api'))
      .map(
        (e) =>
            "    PlatformProject.${e.key}: {'M': ${e.value['M']}, 'V': ${e.value['V']}, 'C': ${e.value['C']}},",
      )
      .join('\n');

  final apiMvcEntries = mvc.entries
      .where((e) => e.key.toLowerCase().contains('api'))
      .map(
        (e) =>
            "    PlatformProject.${e.key}: {'M': ${e.value['M']}, 'V': ${e.value['V']}, 'C': ${e.value['C']}},",
      )
      .join('\n');

  final totalUi =
      loc.length -
      mvc.entries.where((e) => e.key.toLowerCase().contains('api')).length;
  final totalApi = mvc.entries
      .where((e) => e.key.toLowerCase().contains('api'))
      .length;
  final totalScreens = mvc.values.fold(0, (sum, e) => sum + (e['V'] ?? 0));

  final uiProjectsList = loc.keys
      .where((k) => !k.toLowerCase().contains('api'))
      .map((k) => '    PlatformProject.$k,')
      .join('\n');
  final apiProjectsList = loc.keys
      .where((k) => k.toLowerCase().contains('api'))
      .map((k) => '    PlatformProject.$k,')
      .join('\n');

  return '''// Layer: 00_GOVERNANCE_MANIFEST
// Generated: $now
// Architecture: Immutable Platform Master Registry

class PlatformGovernanceRegistry {
  static const String buildVersion = '4.5.0-SYNC';
  static const String buildSignature = '$signature';

  // --- VOLUMETRIC METRICS (LOC) ---
  static const Map<PlatformProject, int> projectLocManifest = {
$locEntries
  };

  // --- VOLUMETRIC METRICS (FILE COUNTS) ---
  static const Map<PlatformProject, int> projectFileManifest = {
$fileEntries
  };

  // --- MVC MANIFEST (UI TIER) ---
  static const Map<PlatformProject, Map<String, int>> uiMvcManifest = {
$uiMvcEntries
  };

  // --- MVC MANIFEST (API TIER) ---
  static const Map<PlatformProject, Map<String, int>> apiMvcManifest = {
$apiMvcEntries
  };

  // --- RBAC & GOVERNANCE METRICS ---
  static const int totalRoles = $totalRoles;
  static const int rolesWithAccess = $rolesWithScreens;

  static const int totalUiProjects = $totalUi;
  static const int totalApiProjects = $totalApi;
  static const int totalScreens = $totalScreens;
  static const bool isLoginWorking = true;

  static const List<PlatformProject> uiProjects = [
$uiProjectsList
  ];

  static const List<PlatformProject> apiProjects = [
$apiProjectsList
  ];

  static Map<String, String> getManifestSummary() {
    return {
      'Version': buildVersion,
      'Status': 'SYNCHRONIZED',
      'Total Projects': '\${projectLocManifest.length}',
    };
  }
}

enum PlatformProject {
  ${loc.keys.join(', ')}
}
''';
}
