import 'dart:io';
import 'dart:convert';

void main() {
  final registriesDir = Directory(
    'apps/primecare_governance/lib/core/governance/registries',
  );

  if (!registriesDir.existsSync()) {
    print('Error: Could not find registries at ${registriesDir.path}');
    exit(1);
  }

  int implementedCount = 0;
  int pendingCount = 0;

  List<Map<String, dynamic>> screensList = [];
  Map<String, Map<String, dynamic>> byApp = {};

  final files = registriesDir.listSync().whereType<File>().where(
    (f) => f.path.endsWith('_registry.dart'),
  );

  for (final file in files) {
    final filename = file.uri.pathSegments.last;
    final content = file.readAsStringSync();

    // Map filename to app
    String app = 'unknown';
    if (filename == 'clinical_registry.dart')
      app = 'prime_clinical';
    else if (filename == 'corporate_registry.dart')
      app = 'prime_corporate';
    else if (filename == 'core_governance_registry.dart')
      app = 'primecare_governance';
    else if (filename == 'operational_registry.dart')
      app = 'prime_operational';
    else if (filename == 'franchise_registry.dart')
      app = 'prime_franchise';
    else if (filename == 'admin_infrastructure_registry.dart')
      app = 'primecare_admin';
    else if (filename == 'regional_finance_registry.dart')
      app = 'prime_finance';
    else if (filename == 'marketing_registry.dart')
      app = 'prime_marketing';
    else if (filename == 'business_development_registry.dart')
      app = 'prime_business_development';
    else if (filename == 'client_portal_registry.dart')
      app = 'prime_client_portal';
    else if (filename == 'support_registry.dart')
      app = 'prime_support';
    else if (filename == 'workflows_forms_registry.dart')
      app = 'prime_workflows_forms';
    else if (filename == 'autogen_registry.dart')
      app = 'prime_autogen';
    else if (filename == 'recovered_registry.dart')
      app = 'prime_recovered';

    // Track by app
    if (!byApp.containsKey(app)) {
      byApp[app] = {'total': 0, 'implemented': 0, 'pending': 0};
    }

    // A simple regex to find ScreenMetadata blocks
    final regex = RegExp(r'ScreenMetadata\(([\s\S]*?)\)', multiLine: true);
    final matches = regex.allMatches(content);

    for (final match in matches) {
      final block = match.group(1) ?? '';

      // Extract id
      final idMatch = RegExp(r"id:\s*'([^']+)'").firstMatch(block);
      final id = idMatch?.group(1) ?? 'unknown_id';

      // Extract office
      final officeMatch = RegExp(r"office:\s*'([^']+)'").firstMatch(block);
      final office = officeMatch?.group(1) ?? 'General';

      // Extract role/charter
      final roleMatch = RegExp(r"role:\s*'([^']+)'").firstMatch(block);
      final charter = roleMatch?.group(1) ?? 'Standard User';

      // Extract status (isRenderOk or similar)
      final statusMatch = RegExp(
        r'isRenderOk:\s*(true|false)',
      ).firstMatch(block);
      final isRenderOk = statusMatch?.group(1) == 'true';

      // For core governance registry, some screens don't have isRenderOk but are implemented
      final isImplemented =
          isRenderOk || filename == 'core_governance_registry.dart';

      if (isImplemented) {
        implementedCount++;
      } else {
        pendingCount++;
      }

      screensList.add({
        'id': id,
        'app': app,
        'office': office,
        'charter': charter,
        'status': isImplemented ? 'implemented' : 'pending',
      });

      byApp[app]!['total'] = (byApp[app]!['total'] as int) + 1;
      if (isImplemented) {
        byApp[app]!['implemented'] = (byApp[app]!['implemented'] as int) + 1;
      } else {
        byApp[app]!['pending'] = (byApp[app]!['pending'] as int) + 1;
      }
    }
  }

  final result = {
    'summary': {
      'total': implementedCount + pendingCount,
      'implemented': implementedCount,
      'pending': pendingCount,
      'implementedPercentage': implementedCount + pendingCount == 0
          ? 0
          : (implementedCount / (implementedCount + pendingCount) * 100)
                .round(),
    },
    'byApp': byApp,
    'screens': screensList,
    'lastUpdated': DateTime.now().toIso8601String(),
  };

  final jsonString = JsonEncoder.withIndent('  ').convert(result);

  // Save JSON to assets
  final outDir = Directory('apps/primecare_governance/assets');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  final outPath = 'apps/primecare_governance/assets/screen_status.json';
  final outFile = File(outPath);
  outFile.writeAsStringSync(jsonString);

  print(
    '✅ Successfully parsed ScreenRegistry files from governance registries.',
  );
  print('Total Screens: ${(result['summary'] as Map)['total']}');
  print('Implemented:   $implementedCount');
  print('Pending:       $pendingCount');
  print('Output saved to: $outPath');
}
