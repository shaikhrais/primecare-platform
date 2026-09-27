import 'dart:io';
import 'package:path/path.dart' as p;

String toCamelCase(String text) {
  final parts = text.split('_');
  if (parts.isEmpty) return '';
  final result = StringBuffer(parts[0]);
  for (var i = 1; i < parts.length; i++) {
    final part = parts[i];
    if (part.isNotEmpty) {
      result.write(part[0].toUpperCase() + part.substring(1));
    }
  }
  return result.toString();
}

String toPascalCase(String text) {
  final camel = toCamelCase(text);
  if (camel.isEmpty) return '';
  return camel[0].toUpperCase() + camel.substring(1);
}

void main() async {
  print('Starting 251-capacity role-wise screen generation...');
  final projectRoot = Directory.current.path;
  final screensDir = p.join(projectRoot, 'packages', 'primecare_ui', 'lib', 'src', 'screens');
  final primecareUiDartPath = p.join(projectRoot, 'packages', 'primecare_ui', 'lib', 'primecare_ui.dart');
  final registryPath = p.join(projectRoot, 'packages', 'primecare_ui', 'lib', 'src', 'registry', 'screen_registry.dart');
  final yamlPath = p.join(projectRoot, '.agents', 'governance', 'page_inventory.yaml');

  final dashboardFiles = Directory(screensDir)
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('_dashboard_screen.dart'))
      .toList();

  int newScreensCount = 0;
  final newExports = <String>[];
  final newWidgetEntries = <String>[];
  final newYamlEntries = <String>[];

  for (final file in dashboardFiles) {
    final parentDir = file.parent;
    final basename = p.basename(file.path);
    final rolePrefix = basename.replaceAll('_dashboard_screen.dart', '');
    final camelPrefix = toCamelCase(rolePrefix);
    final pascalPrefix = toPascalCase(rolePrefix);
    
    final relativeDirPath = p.relative(parentDir.path, from: p.join(projectRoot, 'packages', 'primecare_ui', 'lib'));
    
    final screensToGen = [
      {'suffix': '_analytics_screen.dart', 'type': 'Analytics'},
      {'suffix': '_workflow_screen.dart', 'type': 'Workflow'},
    ];

    for (final def in screensToGen) {
      final type = def['type']!;
      final suffix = def['suffix']!;
      final newFileName = "${rolePrefix}${suffix}";
      final newFilePath = p.join(parentDir.path, newFileName);
      final screenClass = "${pascalPrefix}${type}Screen";
      
      final exportPath = p.normalize(p.join(relativeDirPath, newFileName)).replaceAll(r'\', '/');
      final screenId = "SCREEN_${rolePrefix.toUpperCase()}_${type.toUpperCase()}";

      // Write UI File
      final code = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class $screenClass extends GovernedConsumerWidget {
  const $screenClass({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          '$pascalPrefix $type',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: '$pascalPrefix $type',
              roleName: '$pascalPrefix Module',
              description: 'Centralized $type operations for $pascalPrefix.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colors.border),
              ),
              child: Center(
                child: Text('Integration Sandbox for $pascalPrefix $type Module', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';
      File(newFilePath).writeAsStringSync(code);
      newScreensCount++;
      newExports.add("export '$exportPath';");
      newWidgetEntries.add("    '$screenId': const $screenClass(),");

      // Yaml entry
      final yamlEntry = '''
  - id: "${screenId.toLowerCase()}"
    route: "/${rolePrefix.replaceAll('_', '-')}/${type.toLowerCase()}"
    name: "$screenClass"
    role_allowed: ["$rolePrefix", "admin"]
    actions: ["view_${type.toLowerCase()}"]
    linked_intent: "view_dashboard"''';
      newYamlEntries.add(yamlEntry);
    }
  }

  print('Generated $newScreensCount screens.');

  // Inject Exports
  if (newExports.isNotEmpty) {
    var uiCode = File(primecareUiDartPath).readAsStringSync();
    if (!uiCode.contains(newExports.first)) {
      uiCode += '\n// --- AUTO-HYDRATED NEW ROLE SCREENS ---\n';
      uiCode += newExports.join('\n') + '\n';
      File(primecareUiDartPath).writeAsStringSync(uiCode);
    }
  }

  // Inject into Widget Registry
  if (newWidgetEntries.isNotEmpty) {
    var registryCode = File(registryPath).readAsStringSync();
    if (!registryCode.contains(newWidgetEntries.first.trim())) {
      // Find the end of _widgetRegistry map
      final widgetRegistryEnd = registryCode.indexOf('  };', registryCode.indexOf('_widgetRegistry = {'));
      if (widgetRegistryEnd != -1) {
        final updatedRegistry = registryCode.substring(0, widgetRegistryEnd) +
            '    // --- AUTO-GENERATED ROLE WIDGETS ---\n' +
            newWidgetEntries.join('\n') +
            '\n  ' + registryCode.substring(widgetRegistryEnd);
        File(registryPath).writeAsStringSync(updatedRegistry);
        print('Injected widgets into screen_registry.dart');
      }
    }
  }

  // Inject into YAML
  if (newYamlEntries.isNotEmpty) {
    var yamlCode = File(yamlPath).readAsStringSync();
    if (!yamlCode.contains(newYamlEntries.first.trim())) {
      yamlCode += '\n# --- AUTO-GENERATED ROLE SCREENS ---\n';
      yamlCode += newYamlEntries.join('\n') + '\n';
      File(yamlPath).writeAsStringSync(yamlCode);
      print('Injected metadata into page_inventory.yaml');
    }
  }
}
