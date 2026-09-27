import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as p;

void main() async {
  print('Starting registry hydration to reach 158-screen parity...');

  final projectRoot = Directory.current.path;
  final inventoryPath = p.join(projectRoot, '.agents', 'governance', 'page_inventory.yaml');
  final registryPath = p.join(projectRoot, 'apps', 'primecare_governance', 'lib', 'core', 'governance', 'registries', 'core_governance_registry.dart');

  if (!File(inventoryPath).existsSync()) {
    print('Error: page_inventory.yaml not found at $inventoryPath');
    return;
  }

  if (!File(registryPath).existsSync()) {
    print('Error: core_governance_registry.dart not found at $registryPath');
    return;
  }

  final inventoryContent = File(inventoryPath).readAsStringSync();
  final inventoryYaml = loadYaml(inventoryContent) as YamlMap;
  final pages = inventoryYaml['pages'] as YamlList;


  print('Found ${pages.length} pages in inventory.');

  final registryContent = File(registryPath).readAsStringSync();
  
  // Extract existing screen IDs (supporting keys with or without SCREEN_ prefix)
  final idRegex = RegExp(r"'\s*([A-Z0-9_]+)'\s*:");
  final existingIds = idRegex.allMatches(registryContent).map((m) => m.group(1)).toSet();
  print('Existing registered screens: ${existingIds.length}');

  final newEntries = <String>[];
  int count = 0;

  for (final node in pages) {
    final page = node as YamlMap;
    final id = page['id'] as String;

    final baseId = id.replaceAll('.', '_').toUpperCase();
    final normalizedId = 'SCREEN_$baseId';
    
    if (existingIds.contains(normalizedId) || existingIds.contains(baseId)) continue;
    if (id == 'auth_layout') continue; // Skip layout-only entries if needed

    final name = page['name'] as String? ?? id;
    final route = page['route'] as String? ?? '/generated/$id';
    final roles = (page['role_allowed'] as YamlList?)?.map((r) => r.toString().toUpperCase()).toList() ?? ['ADMIN'];
    
    // Map icon_var to Icons
    String icon = 'Icons.auto_awesome_outlined';
    final iconVar = page['icon_var'] as String?;
    if (iconVar != null) {
      if (iconVar.contains('layoutDashboard')) icon = 'Icons.dashboard_outlined';
      else if (iconVar.contains('shieldCheck')) icon = 'Icons.security_outlined';
      else if (iconVar.contains('users')) icon = 'Icons.people_outline';
      else if (iconVar.contains('globe')) icon = 'Icons.public_outlined';
      else if (iconVar.contains('trendingUp')) icon = 'Icons.trending_up_outlined';
      else if (iconVar.contains('barChart')) icon = 'Icons.bar_chart_outlined';
      else if (iconVar.contains('dollarSign')) icon = 'Icons.attach_money_outlined';
      else if (iconVar.contains('map')) icon = 'Icons.map_outlined';
      else if (iconVar.contains('fileText')) icon = 'Icons.description_outlined';
      else if (iconVar.contains('activity')) icon = 'Icons.local_activity_outlined';
      else if (iconVar.contains('settings')) icon = 'Icons.settings_outlined';
    }

    final entry = '''
    '$normalizedId': ScreenMetadata(
      id: '$normalizedId',
      featureName: '$name',
      title: '$name',
      routePath: '$route',
      icon: $icon,
      allowedRoles: ${roles.toString()},
      lifecycleStatus: LifecycleStatus.design,
      designSize: const PlatformSize(3840, 2160),
      sourcePath: 'packages/primecare_ui/lib/src/registry/screen_registry.dart',
    ),''';
    
    newEntries.add(entry);
    count++;
  }

  print('Prepared $count new entries.');

  if (count > 0) {
    final insertionPoint = registryContent.lastIndexOf('};');
    if (insertionPoint != -1) {
      final updatedContent = registryContent.substring(0, insertionPoint) + 
          '\n    // --- AUTO-HYDRATED ENTRIES ---\n' +
          newEntries.join('\n') + 
          '\n  ' + registryContent.substring(insertionPoint);
      
      File(registryPath).writeAsStringSync(updatedContent);
      print('Successfully hydrated registry with $count new screens.');
    } else {
      print('Error: Could not find insertion point in CoreGovernanceRegistry.dart');
    }
  } else {
    print('No new screens to hydrate.');
  }

  print('Final verification: Counting IDs in updated file...');
  final updatedContent = File(registryPath).readAsStringSync();
  final finalCount = idRegex.allMatches(updatedContent).length;
  print('Total screens in registry: $finalCount');
  
  if (finalCount >= 158) {
    print('SUCCESS: Reached audit threshold of 158 screens!');
  } else {
    print('Note: Current total is $finalCount. Still below 158.');
  }
}
