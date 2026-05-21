import 'dart:io';

void main() {
  final govFile = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  final uiFile = File('packages/primecare_ui/lib/src/registry/screen_registry.dart');

  if (!govFile.existsSync() || !uiFile.existsSync()) {
    print('Error: Core files not found!');
    return;
  }

  // 1. Extract all screen IDs from CoreGovernanceRegistry
  final Set<String> registeredIds = {};
  final RegExp idRegExp = RegExp(r"^\s*'([A-Z0-9_]+)':\s*ScreenMetadata");
  for (final line in govFile.readAsLinesSync()) {
    final match = idRegExp.firstMatch(line);
    if (match != null) {
      registeredIds.add(match.group(1)!);
    }
  }

  // 2. Extract mappings from screen_registry.dart
  final Map<String, String> mappedScreens = {};
  final uiLines = uiFile.readAsLinesSync();
  for (final line in uiLines) {
    if (line.trim().startsWith("'") && (line.contains("': ") || line.contains("':\t"))) {
      final parts = line.split("':");
      if (parts.length >= 2) {
        final screenId = parts[0].trim().replaceAll("'", "").replaceAll('"', '');
        final impl = parts.sublist(1).join("':").trim().replaceAll(',', '');
        mappedScreens[screenId] = impl;
      }
    }
  }

  // 3. Scan physical folders for all available widget classes
  final Map<String, ({String filePath, String className})> availableWidgets = {};

  // Scan generated_screens
  final genDir = Directory('packages/primecare_ui/lib/src/features/generated_screens');
  if (genDir.existsSync()) {
    for (final file in genDir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart'))) {
      final filename = file.path.split('/').last.split('\\').last;
      availableWidgets[filename.split('.dart').first] = (filePath: '../features/generated_screens/$filename', className: filename.split('.dart').first);
      
      final content = file.readAsStringSync();
      final classMatch = RegExp(r'class\s+([A-Za-z0-9_]+)\s+extends').firstMatch(content);
      if (classMatch != null) {
        availableWidgets[classMatch.group(1)!] = (filePath: '../features/generated_screens/$filename', className: classMatch.group(1)!);
      }
    }
  }

  // Scan all other directories in primecare_ui/lib/src
  final libDir = Directory('packages/primecare_ui/lib/src');
  if (libDir.existsSync()) {
    for (final file in libDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'))) {
      if (file.path.contains('generated_screens')) continue;
      
      final content = file.readAsStringSync();
      final classMatches = RegExp(r'class\s+([A-Za-z0-9_]+)\s+extends').allMatches(content);
      
      // Calculate relative path from packages/primecare_ui/lib/src/registry/screen_registry.dart
      final normalizedPath = file.path.replaceAll('\\', '/');
      final relativePath = normalizedPath.replaceFirst('packages/primecare_ui/lib/src/', '../');

      for (final m in classMatches) {
        availableWidgets[m.group(1)!] = (filePath: relativePath, className: m.group(1)!);
      }
    }
  }

  // 4. Gather premium_feature_ files in sorted order
  final List<({String filePath, String className})> sortedPremiumFeatures = [];
  final List<String> sortedClassNames = availableWidgets.keys.where((k) => k.startsWith('PremiumFeature') && RegExp(r'\d+').hasMatch(k)).toList();
  sortedClassNames.sort((a, b) {
    final numA = int.parse(RegExp(r'\d+').firstMatch(a)!.group(0)!);
    final numB = int.parse(RegExp(r'\d+').firstMatch(b)!.group(0)!);
    return numA.compareTo(numB);
  });
  for (final className in sortedClassNames) {
    sortedPremiumFeatures.add(availableWidgets[className]!);
  }

  print('Total registered IDs: ${registeredIds.length}');
  print('Total mapped in screen_registry.dart: ${mappedScreens.length}');
  print('Total physical widgets found: ${availableWidgets.length}');
  print('Total premium feature widgets found: ${sortedPremiumFeatures.length}');

  // 5. Build mapping proposal
  final List<String> missingList = [];
  final List<String> mappedList = [];
  final Map<String, ({String filePath, String className})> mappingsToAdd = {};
  int premiumIndex = 0;

  for (final id in registeredIds) {
    final hasMapping = mappedScreens.containsKey(id) || mappedScreens.containsKey('SCREEN_$id');
    if (hasMapping) {
      mappedList.add(id);
      continue;
    }

    missingList.add(id);

    // Identify matching widget
    if (id.startsWith('SCREEN_SCREEN_')) {
      // Map to next available premium feature
      if (premiumIndex < sortedPremiumFeatures.length) {
        mappingsToAdd[id] = sortedPremiumFeatures[premiumIndex];
        premiumIndex++;
      } else {
        print('Warning: No more premium features for $id!');
      }
    } else {
      // Find matching standard screen
      final cleanKey = id.replaceFirst('SCREEN_', '');
      final parts = cleanKey.split('_');
      final pascalKey = parts.map((p) => p[0].toUpperCase() + p.substring(1).toLowerCase()).join('');

      final candidates = [
        pascalKey,
        '${pascalKey}Screen',
        '${pascalKey}Form',
        '${pascalKey}View',
        '${pascalKey}Widget',
      ];

      ({String filePath, String className})? matchedWidget;
      for (final cand in candidates) {
        if (availableWidgets.containsKey(cand)) {
          matchedWidget = availableWidgets[cand];
          break;
        }
      }

      if (matchedWidget == null) {
        // Try loose match
        final cleanLower = cleanKey.toLowerCase().replaceAll('_', '');
        for (final className in availableWidgets.keys) {
          final classLower = className.toLowerCase();
          if (classLower == cleanLower || classLower == '${cleanLower}screen' || classLower == '${cleanLower}view') {
            matchedWidget = availableWidgets[className];
            break;
          }
        }
      }

      if (matchedWidget != null) {
        mappingsToAdd[id] = matchedWidget;
      } else {
        print('Warning: Could not find any widget for key $id!');
      }
    }
  }

  print('\n--- SUMMARY ---');
  print('Already Mapped: ${mappedList.length}');
  print('Missing:        ${missingList.length}');
  print('Wired to Add:   ${mappingsToAdd.length}');

  // Save the mapping to a JSON file so that the auto-wirer can use it directly
  final jsonFile = File('scratch/proposed_mappings.json');
  final sb = StringBuffer();
  sb.writeln('{');
  final entries = mappingsToAdd.entries.toList();
  for (int i = 0; i < entries.length; i++) {
    final entry = entries[i];
    sb.write('  "${entry.key}": { "filePath": "${entry.value.filePath}", "className": "${entry.value.className}" }');
    if (i < entries.length - 1) sb.writeln(',');
    else sb.writeln('');
  }
  sb.writeln('}');
  jsonFile.writeAsStringSync(sb.toString());
  print('Proposed mappings saved to scratch/proposed_mappings.json');
}
