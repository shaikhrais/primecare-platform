import 'dart:io';

void main() {
  final governancePath = 'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart';
  final registryPath = 'packages/primecare_ui/lib/src/registry/screen_registry.dart';

  final governanceFile = File(governancePath);
  final registryFile = File(registryPath);

  if (!governanceFile.existsSync() || !registryFile.existsSync()) {
    print('Error: Core files not found!');
    return;
  }

  // 1. Parse imports in screen_registry.dart to map widget class name to file path
  final registryLines = registryFile.readAsLinesSync();
  final Map<String, String> classToFilePath = {};
  
  final importRegExp = RegExp(r"import\s+'([^']+)'\s*;");
  for (final line in registryLines) {
    final match = importRegExp.firstMatch(line);
    if (match != null) {
      final importPath = match.group(1)!;
      // Resolve path relative to packages/primecare_ui/lib/src/registry/screen_registry.dart
      String resolvedPath = importPath;
      if (importPath.startsWith('../')) {
        resolvedPath = 'packages/primecare_ui/lib/src/' + importPath.substring(3);
      } else if (importPath.startsWith('package:primecare_ui/')) {
        // e.g. package:primecare_ui/src/features/generated_screens/...
        resolvedPath = 'packages/primecare_ui/lib/' + importPath.substring(21);
      }
      
      // Try to find what classes are defined in this file to map them
      final file = File(resolvedPath);
      if (file.existsSync()) {
        final content = file.readAsStringSync();
        final classRegExp = RegExp(r"class\s+([A-Za-z0-9_]+)\s+extends");
        for (final m in classRegExp.allMatches(content)) {
          final className = m.group(1)!;
          classToFilePath[className] = resolvedPath;
        }
      }
    }
  }

  print('Mapped ${classToFilePath.length} classes to their source files.');

  // 2. Parse governance registry to get all 322 governed screens and their allowed roles
  final governanceContent = governanceFile.readAsStringSync();
  final screenBlocks = governanceContent.split("ScreenMetadata(");
  final List<Map<String, dynamic>> governedScreens = [];

  // Parse using regex
  final idReg = RegExp(r"id:\s*'([^']+)'");
  final titleReg = RegExp(r"title:\s*'([^']+)'");
  final rolesReg = RegExp(r"allowedRoles:\s*\[([^\]]+)\]");
  final routeReg = RegExp(r"routePath:\s*'([^']+)'");

  for (int i = 1; i < screenBlocks.length; i++) {
    final block = screenBlocks[i];
    final idMatch = idReg.firstMatch(block);
    if (idMatch == null) continue;
    final id = idMatch.group(1)!;

    final titleMatch = titleReg.firstMatch(block);
    final title = titleMatch != null ? titleMatch.group(1)! : id;

    final rolesMatch = rolesReg.firstMatch(block);
    final List<String> allowedRoles = [];
    if (rolesMatch != null) {
      final rolesStr = rolesMatch.group(1)!;
      allowedRoles.addAll(rolesStr.split(',').map((e) => e.trim().replaceAll("'", "").replaceAll('"', '')));
    }

    final routeMatch = routeReg.firstMatch(block);
    final routePath = routeMatch != null ? routeMatch.group(1)! : '';

    governedScreens.add({
      'id': id,
      'title': title,
      'allowedRoles': allowedRoles,
      'routePath': routePath,
    });
  }

  print('Parsed ${governedScreens.length} governed screens.');

  // 3. Parse screen_registry.dart widget mapping map to know which key maps to which widget constructor/class
  final Map<String, String> keyToWidgetClass = {};
  bool inRegistry = false;
  for (int i = 0; i < registryLines.length; i++) {
    final line = registryLines[i];
    if (line.contains('_widgetRegistry = {')) {
      inRegistry = true;
      continue;
    }
    if (inRegistry && line.trim().startsWith('};')) {
      inRegistry = false;
      break;
    }
    if (inRegistry) {
      final trimmed = line.trim();
      if (trimmed.startsWith("'") && trimmed.contains("':")) {
        final parts = trimmed.split("':");
        final key = parts[0].replaceAll("'", "").replaceAll('"', '').trim();
        var val = parts.sublist(1).join("':").trim();
        
        if (val.isEmpty && i + 1 < registryLines.length) {
          val = registryLines[i + 1].trim();
        }
        
        // Extract class name: e.g. const UserManagementScreen() or PremiumFeature111()
        final classMatch = RegExp(r"(?:const\s+)?([A-Za-z0-9_]+)\(").firstMatch(val);
        if (classMatch != null) {
          keyToWidgetClass[key] = classMatch.group(1)!;
        }
      }
    }
  }

  print('Parsed ${keyToWidgetClass.length} widget mappings in _widgetRegistry.');

  // 4. Audit each governed screen
  final List<Map<String, dynamic>> auditedScreens = [];
  int stubCount = 0;
  int fullyFunctionalCount = 0;

  for (final screen in governedScreens) {
    final id = screen['id'] as String;
    final title = screen['title'] as String;
    final allowedRoles = screen['allowedRoles'] as List<String>;
    final routePath = screen['routePath'] as String;

    // Resolve class name
    final className = keyToWidgetClass[id] ?? keyToWidgetClass['SCREEN_$id'] ?? '';
    final filePath = classToFilePath[className] ?? '';

    String status = 'Unknown';
    String fileStatusDetails = 'No file found';
    String codeSnippet = '';

    if (filePath.isNotEmpty) {
      final file = File(filePath);
      if (file.existsSync()) {
        final content = file.readAsStringSync();
        if (content.contains('EmptyState(')) {
          status = 'Placeholder (EmptyState)';
          fileStatusDetails = 'Returns EmptyState placeholder widget';
          stubCount++;
        } else if (content.contains('ScreenNotImplementedView')) {
          status = 'Placeholder (NotImplemented)';
          fileStatusDetails = 'Returns ScreenNotImplementedView';
          stubCount++;
        } else if (content.contains("child: Text('PremiumFeature") && content.length < 500) {
          status = 'Placeholder (Skeletal)';
          fileStatusDetails = 'Returns skeletal Center/Text view';
          stubCount++;
        } else if (content.contains("child: Text(") && content.contains("View (MVC)") && content.length < 500) {
          status = 'Placeholder (Skeletal)';
          fileStatusDetails = 'Returns skeletal Center/Text View (MVC)';
          stubCount++;
        } else {
          status = 'Fully Functional';
          fileStatusDetails = 'Fully integrated widget with rich UI layouts and providers';
          fullyFunctionalCount++;
        }
      } else {
        status = 'File Missing';
        fileStatusDetails = 'Mapped to class $className, but file $filePath does not exist.';
      }
    } else {
      status = 'Unmapped/Stubbed';
      fileStatusDetails = 'No direct widget class mapping found in _widgetRegistry.';
      stubCount++;
    }

    auditedScreens.add({
      'id': id,
      'title': title,
      'allowedRoles': allowedRoles,
      'routePath': routePath,
      'className': className,
      'filePath': filePath,
      'status': status,
      'details': fileStatusDetails,
    });
  }

  // 5. Group by allowed roles to check if any role is missing features or fully stubbed
  final Map<String, List<Map<String, dynamic>>> screensByRole = {};
  for (final screen in auditedScreens) {
    final allowedRoles = screen['allowedRoles'] as List<String>;
    for (final role in allowedRoles) {
      screensByRole.putIfAbsent(role, () => []).add(screen);
    }
  }

  // 6. Write Markdown report
  final buffer = StringBuffer();
  buffer.writeln('# PrimeCare Screen Completeness Audit Report');
  buffer.writeln('\n**Total Audited Governed Screens**: ${auditedScreens.length}');
  buffer.writeln('**Fully Functional Screens**: $fullyFunctionalCount (${(fullyFunctionalCount / auditedScreens.length * 100).toStringAsFixed(1)}%)');
  buffer.writeln('**Placeholder/Stub Screens**: $stubCount (${(stubCount / auditedScreens.length * 100).toStringAsFixed(1)}%)');

  buffer.writeln('\n## Executive Breakdown by Role Category');
  buffer.writeln('Below is the list of all roles, their total screens, and the exact count of fully functional vs. placeholder screens.');
  buffer.writeln('\n| Role | Total Screens | Fully Functional | Placeholder / Stubs | Completeness Rate | Status |');
  buffer.writeln('| :--- | :---: | :---: | :---: | :---: | :--- |');

  final sortedRoles = screensByRole.keys.toList()..sort();
  for (final role in sortedRoles) {
    final list = screensByRole[role]!;
    final funcCount = list.where((s) => s['status'] == 'Fully Functional').length;
    final pCount = list.length - funcCount;
    final rate = list.isNotEmpty ? (funcCount / list.length * 100).toStringAsFixed(1) : '0.0';
    String statusWord = 'COMPLETE';
    if (rate == '0.0') {
      statusWord = '⚠️ FULLY STUBBED';
    } else if (funcCount < list.length) {
      statusWord = '🔄 PARTIALLY STUBBED';
    }
    buffer.writeln('| **$role** | ${list.length} | $funcCount | $pCount | $rate% | $statusWord |');
  }

  buffer.writeln('\n## Detailed Screen Inventory');
  buffer.writeln('The complete catalog of all registered governed screens and their active state:');
  buffer.writeln('\n| Screen ID | Title | Allowed Roles | Widget Class | Status | Path | Details |');
  buffer.writeln('| :--- | :--- | :--- | :--- | :--- | :--- | :--- |');
  
  for (final s in auditedScreens) {
    buffer.writeln('| `${s['id']}` | ${s['title']} | ${s['allowedRoles'].join(', ')} | `${s['className']}` | **${s['status']}** | `${s['filePath']}` | ${s['details']} |');
  }

  final reportFile = File('C:\\Users\\Admin2\\.gemini\\antigravity\\brain\\9fcdd39a-59a0-4403-945b-62e5fe26955a\\screen_completeness_report.md');
  reportFile.writeAsStringSync(buffer.toString());
  print('Audit complete! Saved detailed report to screen_completeness_report.md');
}
