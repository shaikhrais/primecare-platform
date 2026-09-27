import 'dart:convert';
import 'dart:io';

void main() {
  final inventoryFile = File('.agents/governance/page_inventory.yaml');
  if (!inventoryFile.existsSync()) {
    print('Failed to open page_inventory.yaml');
    exit(1);
  }

  final String yaml = inventoryFile.readAsStringSync();
  final Map<String, String> items = {};
  final Map<String, String> sections = {};

  // Split by list items
  final blocks = yaml.split(RegExp(r'\n\s*-\s+'));

  for (final block in blocks) {
    // Improved regex to handle optional quotes
    final idMatch = RegExp(r'id:\s*"?([^"\n\s]+)"?').firstMatch(block);
    final labelMatch = RegExp(r'label:\s*"?([^"\n]+?)"?\s*\n').firstMatch(block);
    final sectionMatch = RegExp(r'section:\s*"?([^"\n]+?)"?\s*\n').firstMatch(block);

    if (idMatch != null && labelMatch != null) {
      final id = idMatch.group(1)!;
      final label = labelMatch.group(1)!;
      items[id] = label;

      if (sectionMatch != null) {
        final section = sectionMatch.group(1)!;
        final sectionKey = section.toLowerCase().replaceAll(' ', '_');
        sections[sectionKey] = section;
      }
    }
  }

  print('Found ${items.length} items and ${sections.length} sections.');

  // Define Aura keys
  final aura = {
    "search_hint": "Search Aura intelligence...",
    "profile": "Profile Overview",
    "system_preferences": "System Preferences",
    "sign_out": "Sign Out",
    "confirm_departure": "Confirm Departure",
    "exit_message": "Are you sure you want to end your current session?",
    "stay": "Stay",
    "exit_session": "Exit Session"
  };

  final translationFiles = [
    'apps/primecare_corporate/assets/translations/en.json',
  ];

  for (final filePath in translationFiles) {
    final file = File(filePath);
    if (!file.existsSync()) continue;

    final content = file.readAsStringSync();
    final Map<String, dynamic> json = jsonDecode(content);

    // We will update navigation items and sections as FLAT keys if they were already flat,
    // but the code expects navigation.items.xxx.
    // EasyLocalization handles nested JSON by default.
    
    // Create nested structure
    json['navigation'] = {
      'items': items,
      'sections': sections,
    };

    // Update aura
    json['aura'] = aura;

    // Save back with indentation
    final encoder = JsonEncoder.withIndent('  ');
    file.writeAsStringSync(encoder.convert(json));
    print('✅ Updated $filePath');
  }
}
