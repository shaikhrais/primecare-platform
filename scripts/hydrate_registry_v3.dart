import 'dart:io';
import 'package:path/path.dart' as p;

class Page {
  String id = '';
  String route = '';
  String name = '';
  String iconVar = '';
  List<String> roles = [];
}

void main() async {
  print('Starting line-by-line registry hydration...');

  final projectRoot = Directory.current.path;
  final inventoryPath = p.join(projectRoot, '.agents', 'governance', 'page_inventory.yaml');
  final registryPath = p.join(projectRoot, 'apps', 'primecare_governance', 'lib', 'core', 'governance', 'registries', 'core_governance_registry.dart');

  final lines = File(inventoryPath).readAsLinesSync();
  final List<Page> pages = [];
  Page? currentPage;

  for (var line in lines) {
    line = line.trim();
    if (line.startsWith('- id:')) {
      if (currentPage != null) pages.add(currentPage);
      currentPage = Page();
      currentPage.id = line.split('"')[1];
    } else if (line.startsWith('route:')) {
      currentPage?.route = line.split('"')[1];
    } else if (line.startsWith('name:')) {
      currentPage?.name = line.split('"')[1];
    } else if (line.startsWith('icon_var:')) {
      currentPage?.iconVar = line.split('"')[1];
    } else if (line.startsWith('role_allowed:')) {
      final rolesStr = line.split('[')[1].split(']')[0];
      currentPage?.roles = rolesStr.split(',').map((r) => r.trim().replaceAll('"', '').toUpperCase()).toList();
    }
  }
  if (currentPage != null) pages.add(currentPage);

  print('Found ${pages.length} pages in inventory.');

  final registryContent = File(registryPath).readAsStringSync();
  final idRegex = RegExp(r"'(SCREEN_[A-Z0-9_]+)':");
  final existingIds = idRegex.allMatches(registryContent).map((m) => m.group(1)).toSet();

  final newEntries = <String>[];
  int count = 0;

  for (final page in pages) {
    final normalizedId = 'SCREEN_${page.id.replaceAll('.', '_').toUpperCase()}';
    if (existingIds.contains(normalizedId)) continue;
    if (page.id == 'auth_layout') continue;

    String icon = 'Icons.auto_awesome_outlined';
    if (page.iconVar.isNotEmpty) {
       if (page.iconVar.contains('layoutDashboard')) icon = 'Icons.dashboard_outlined';
      else if (page.iconVar.contains('shieldCheck')) icon = 'Icons.security_outlined';
      else if (page.iconVar.contains('users')) icon = 'Icons.people_outline';
      else if (page.iconVar.contains('globe')) icon = 'Icons.public_outlined';
      else if (page.iconVar.contains('trendingUp')) icon = 'Icons.trending_up_outlined';
      else if (page.iconVar.contains('barChart')) icon = 'Icons.bar_chart_outlined';
      else if (page.iconVar.contains('dollarSign')) icon = 'Icons.attach_money_outlined';
      else if (page.iconVar.contains('map')) icon = 'Icons.map_outlined';
      else if (page.iconVar.contains('fileText')) icon = 'Icons.description_outlined';
      else if (page.iconVar.contains('activity')) icon = 'Icons.local_activity_outlined';
      else if (page.iconVar.contains('settings')) icon = 'Icons.settings_outlined';
    }

    final entry = '''
    '$normalizedId': ScreenMetadata(
      id: '$normalizedId',
      featureName: '${page.name}',
      title: '${page.name}',
      routePath: '${page.route}',
      icon: $icon,
      allowedRoles: ${page.roles.toString()},
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
