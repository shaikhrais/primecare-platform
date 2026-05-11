import 'dart:io';
import 'package:path/path.dart' as p;

void main() async {
  print('Starting regex-based registry hydration...');

  final projectRoot = Directory.current.path;
  final inventoryPath = p.join(projectRoot, '.agents', 'governance', 'page_inventory.yaml');
  final registryPath = p.join(projectRoot, 'apps', 'primecare_governance', 'lib', 'core', 'governance', 'registries', 'core_governance_registry.dart');

  if (!File(inventoryPath).existsSync()) {
    print('Error: page_inventory.yaml not found at $inventoryPath');
    return;
  }

  final inventoryContent = File(inventoryPath).readAsStringSync();
  
  // Simple regex to extract pages. This is fragile but works for the current format.
  final pageBlockRegex = RegExp(r'- id: "([^"]+)"\s+route: "([^"]+)"\s+name: "([^"]+)"(?:\s+label: "[^"]+")?(?:\s+route_var: "[^"]+")?(?:\s+icon_var: "([^"]+)")?(?:\s+section: "[^"]+")?\s+role_allowed: \[([^\]]+)\]', multiLine: true);
  
  final matches = pageBlockRegex.allMatches(inventoryContent);
  print('Found ${matches.length} pages in inventory using regex.');

  final registryContent = File(registryPath).readAsStringSync();
  final idRegex = RegExp(r"'(SCREEN_[A-Z0-9_]+)':");
  final existingIds = idRegex.allMatches(registryContent).map((m) => m.group(1)).toSet();
  print('Existing registered screens: ${existingIds.length}');

  final newEntries = <String>[];
  int count = 0;

  for (final match in matches) {
    final id = match.group(1)!;
    final route = match.group(2)!;
    final name = match.group(3)!;
    final iconVar = match.group(4);
    final rolesStr = match.group(5)!;
    
    final normalizedId = 'SCREEN_${id.replaceAll('.', '_').toUpperCase()}';
    
    if (existingIds.contains(normalizedId)) continue;
    if (id == 'auth_layout') continue;

    final roles = rolesStr.split(',').map((r) => r.trim().replaceAll('"', '').toUpperCase()).toList();
    
    String icon = 'Icons.auto_awesome_outlined';
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
    }
  }

  final finalContent = File(registryPath).readAsStringSync();
  final finalCount = idRegex.allMatches(finalContent).length;
  print('Total screens in registry: $finalCount');
}
