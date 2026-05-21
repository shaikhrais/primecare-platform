import 'dart:convert';
import 'dart:io';

void main() {
  final mappingsFile = File('scratch/proposed_mappings.json');
  final registryFile = File('packages/primecare_ui/lib/src/registry/screen_registry.dart');

  if (!mappingsFile.existsSync() || !registryFile.existsSync()) {
    print('Error: Core files not found!');
    return;
  }

  // 1. Read mappings
  final Map<String, dynamic> mappings = jsonDecode(mappingsFile.readAsStringSync());
  print('Loaded ${mappings.length} mappings from proposed_mappings.json');

  // 2. Read existing registry content
  final String content = registryFile.readAsStringSync();
  final List<String> lines = content.split(RegExp(r'\r?\n'));

  // 3. Find existing imports
  final Set<String> existingImports = {};
  final RegExp importRegExp = RegExp(r"import\s+'([^']+)';");
  for (final line in lines) {
    final match = importRegExp.firstMatch(line);
    if (match != null) {
      existingImports.add(match.group(1)!);
    }
  }
  print('Found ${existingImports.length} existing imports in screen_registry.dart');

  // 4. Generate new imports
  final List<String> newImports = [];
  for (final entry in mappings.values) {
    final filePath = entry['filePath'] as String;
    if (!existingImports.contains(filePath) && !newImports.contains(filePath)) {
      newImports.add(filePath);
    }
  }
  print('Will add ${newImports.length} new imports');

  // 5. Build new imports code block
  final String importsBlock = newImports.map((p) => "import '$p';").join('\n');

  // 6. Find insertion point for imports (right before 'class ScreenRegistry')
  int classIndex = -1;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('class ScreenRegistry')) {
      classIndex = i;
      break;
    }
  }

  if (classIndex == -1) {
    print('Error: Could not find class ScreenRegistry!');
    return;
  }

  // 7. Find insertion point for mappings (the closing brace of _widgetRegistry map)
  // Let's locate the line: '  static final Map<String, Widget> _widgetRegistry = {'
  int mapStartIndex = -1;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('static final Map<String, Widget> _widgetRegistry = {')) {
      mapStartIndex = i;
      break;
    }
  }

  if (mapStartIndex == -1) {
    print('Error: Could not find start of _widgetRegistry map!');
    return;
  }

  // Find the closing brace of the map (the line '  };' right after map items)
  int mapEndIndex = -1;
  for (int i = mapStartIndex; i < lines.length; i++) {
    if (lines[i].trim() == '};') {
      mapEndIndex = i;
      break;
    }
  }

  if (mapEndIndex == -1) {
    print('Error: Could not find end of _widgetRegistry map!');
    return;
  }

  // 8. Generate new mappings code block
  final List<String> newMappingLines = [];
  mappings.forEach((key, val) {
    final className = val['className'] as String;
    // Map with 'SCREEN_' prefix if the key in the registry doesn't have it,
    // and also check if we need SCREEN_ prefix. The key might be "SCREEN_SHIFT_TRACKER"
    // and registered ID will look for both. So we can add it as defined.
    newMappingLines.add("    '$key': const $className(),");
  });
  final String mappingsBlock = newMappingLines.join('\n');

  // 9. Reconstruct the file contents
  final List<String> outputLines = [];
  
  // Add lines up to classIndex
  outputLines.addAll(lines.sublist(0, classIndex));
  // Insert new imports
  outputLines.add(importsBlock);
  outputLines.add('');
  // Add class definition up to mapEndIndex
  outputLines.addAll(lines.sublist(classIndex, mapEndIndex));
  // Insert new mappings
  outputLines.add(mappingsBlock);
  // Add the rest of the file from mapEndIndex
  outputLines.addAll(lines.sublist(mapEndIndex));

  // 10. Write the modified content back
  registryFile.writeAsStringSync(outputLines.join('\n'));
  print('Successfully auto-wired all ${mappings.length} remaining screens to screen_registry.dart!');
}
