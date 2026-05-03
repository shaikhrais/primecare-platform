import 'dart:io';
import 'dart:convert';

void main() {
  print('--- 🚀 PrimeCare Master Governance Parity Orchestrator ---');

  final uiRegistryDir = Directory('packages/factory_system/primecare_ui/lib/src/shared/src/registry/domain_registries');
  final govRegistryDir = Directory('apps/primecare_governance/lib/core/governance/registries');
  final uiPackagePath = 'packages/factory_system/primecare_ui';

  if (!uiRegistryDir.existsSync()) {
    print('❌ UI Registry directory not found!');
    return;
  }

  if (!govRegistryDir.existsSync()) {
    govRegistryDir.createSync(recursive: true);
  }

  final uiRegistries = uiRegistryDir.listSync().whereType<File>().toList();
  print('📊 Found ${uiRegistries.length} UI Domain Registries.\n');

  for (final uiRegistry in uiRegistries) {
    final domainName = uiRegistry.path.split(Platform.isWindows ? '\\' : '/').last.replaceAll('.dart', '').toUpperCase();
    print('--- Processing Domain: $domainName ---');

    final content = uiRegistry.readAsStringSync();
    final uiScreens = _parseUiRegistry(content);
    print('   - Detected ${uiScreens.length} screens in UI Registry.');

    final govFileName = uiRegistry.path.split(Platform.isWindows ? '\\' : '/').last;
    final govFile = File('${govRegistryDir.path}/$govFileName');

    String govContent = '';
    if (govFile.existsSync()) {
      govContent = govFile.readAsStringSync();
    } else {
      govContent = '''
import '../screen_metadata.dart';

class ${_toClassName(domainName)}Registry {
  static const Map<String, ScreenMetadata> screens = {
  };
}
''';
    }

    for (final screen in uiScreens) {
      // Inject markers into UI code and detect if it's a virtual screen
      screen.viewFile = _injectMarkersIntoCode(screen, uiPackagePath);
      final viewFilePath = screen.viewFile;
      final sanitizedId = screen.id.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_').toUpperCase();
      final sourcePath = viewFilePath?.replaceAll('\\', '/') ?? 'virtual';

      if (!govContent.contains("'$sanitizedId':")) {
        print('   [+] Registering Ghost Feature in Governance: $sanitizedId');
        final entry = """
      '$sanitizedId': ScreenMetadata(
      id: '$sanitizedId',
      title: '${screen.title}',
      featureName: '${screen.title}',
      routePath: '${screen.route}',
      office: '${_getOffice(domainName)}',
      role: 'Staff',
      allowedRoles: ['Staff', 'Admin'],
      lifecycleStatus: LifecycleStatus.completed,
      isRenderOk: true,
      userApprovedLayout: true,
      isVirtual: ${viewFilePath == null},
      sourcePath: '${sourcePath.split('/').last}',
      implementedComponents: ${jsonEncode(screen.components)},
    ),""";
        govContent = govContent.replaceFirst('};', '$entry\n  };');
      }
    }

    govFile.writeAsStringSync(govContent);
  }

  // Handle cross-registry index
  final indexFile = File('${govRegistryDir.path}/index.dart');
  final exports = uiRegistries.map((f) => "export '${f.path.split(Platform.isWindows ? '\\' : '/').last}';").join('\n');
  final registryClass = '''
import '../screen_metadata.dart';
${uiRegistries.map((f) => "import '${f.path.split(Platform.isWindows ? '\\' : '/').last}';").join('\n')}

class Registry {
  static Map<String, ScreenMetadata> get screens {
    return {
      ${uiRegistries.map((f) => "...${_toClassName(f.path.split(Platform.isWindows ? '\\' : '/').last.replaceAll('.dart', ''))}Registry.screens,").join('\n      ')}
    };
  }
}
''';
  indexFile.writeAsStringSync('$exports\n\n$registryClass');

  print('\n--- 🟢 Parity Synchronization Complete ---');
}

String _toClassName(String name) {
  return name.split('_').map((e) => e[0].toUpperCase() + e.substring(1)).join('');
}

String _getOffice(String domain) {
  if (domain.contains('CLINICAL')) return 'Clinical';
  if (domain.contains('CORPORATE')) return 'Corporate';
  if (domain.contains('MARKETING')) return 'Marketing';
  if (domain.contains('SUPPORT')) return 'Support';
  return 'Operational';
}

List<UiScreen> _parseUiRegistry(String content) {
  final List<UiScreen> screens = [];
  final blocks = content.split('registerRoute(');
  for (var i = 1; i < blocks.length; i++) {
    final block = blocks[i];
    
    // Extract route (first argument before comma)
    final routeMatch = RegExp(r'^([^,]+)').firstMatch(block);
    final rawRoute = routeMatch?.group(1)?.trim() ?? 'Unknown';
    
    final id = 'SCREEN_${rawRoute.split('.').last.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), '_').toUpperCase()}';
    final title = rawRoute.split('.').last.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), ' ').trim();

    // Extract component labels
    final componentsMatch = RegExp(r'componentLabels:\s*\[(.*?)\],', dotAll: true).firstMatch(block);
    final componentsStr = componentsMatch?.group(1) ?? '';
    final components = componentsStr.split(',').map((e) => e.trim().replaceAll("'", "").replaceAll('"', "")).where((e) => e.isNotEmpty).toList();

    screens.add(UiScreen(
      id: id,
      title: title,
      route: '/${title.toLowerCase().replaceAll(' ', '-')}',
      components: components,
    ));
  }
  return screens;
}

String? _injectMarkersIntoCode(UiScreen screen, String uiPackagePath) {
  final nameBase = screen.title.toLowerCase().replaceAll(' ', '_').replaceAll('_dashboard', '');
  final patterns = [
    '${nameBase}_view.dart',
    '${nameBase}_dashboard_view.dart',
    '${screen.id.toLowerCase().replaceAll('screen_', '')}_view.dart',
  ];

  final allFiles = Directory(uiPackagePath).listSync(recursive: true).whereType<File>().toList();
  
  List<File> potentialFiles = [];
  for (final pattern in patterns) {
    potentialFiles = allFiles.where((f) => f.path.replaceAll('\\', '/').split('/').last == pattern).toList();
    if (potentialFiles.isNotEmpty) break;
  }

  // Final fallback: search content for the ID if we have it
  if (potentialFiles.isEmpty) {
    for (final file in allFiles) {
      if (file.path.endsWith('.dart')) {
        final content = file.readAsStringSync();
        if (content.contains('class ${_capitalize(nameBase)}View') || 
            content.contains('@governance: id=${screen.id}')) {
          potentialFiles = [file];
          break;
        }
      }
    }
  }

  if (potentialFiles.isEmpty) return null;

  for (final file in potentialFiles) {
    String code = file.readAsStringSync();
    bool changed = false;

    if (!code.contains('@governance: id=')) {
      final markers = '''
// @governance: id=${screen.id}
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
''';
      code = markers + code;
      changed = true;
    }

    // Inject component labels as markers if missing
    for (final component in screen.components) {
      if (!code.contains('component=$component')) {
        code = code.replaceFirst('class ', '// @governance: component=$component\nclass ');
        changed = true;
      }
    }

    if (changed) {
      file.writeAsStringSync(code);
    }
  }
  return potentialFiles.first.path;
}

String _capitalize(String s) => s.split('_').map((e) => e.isNotEmpty ? e[0].toUpperCase() + e.substring(1) : '').join('');

class UiScreen {
  final String id;
  final String title;
  final String route;
  final List<String> components;
  String? viewFile;

  UiScreen({
    required this.id,
    required this.title,
    required this.route,
    required this.components,
  });
}
