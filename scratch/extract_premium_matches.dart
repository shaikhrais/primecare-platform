import 'dart:io';

void main() {
  final govFile = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  if (!govFile.existsSync()) {
    print('Core governance registry not found!');
    return;
  }

  // Extract all keys from CoreGovernanceRegistry
  final content = govFile.readAsStringSync();
  final screenBlockRegex = RegExp(
    r"'(\w+)':\s*ScreenMetadata\((.*?)\),",
    dotAll: true,
  );
  
  final Map<String, ({String id, String featureName, String title})> govMetadata = {};
  for (final match in screenBlockRegex.allMatches(content)) {
    final key = match.group(1)!;
    final block = match.group(2)!;
    
    final idMatch = RegExp(r"id:\s*'([^']+)'").firstMatch(block);
    final id = idMatch?.group(1) ?? 'Unknown';

    final featureNameMatch = RegExp(r"featureName:\s*'([^']*)'").firstMatch(block);
    final featureName = featureNameMatch?.group(1) ?? '';

    final titleMatch = RegExp(r"title:\s*'([^']*)'").firstMatch(block);
    final title = titleMatch?.group(1) ?? '';

    govMetadata[key] = (id: id, featureName: featureName, title: title);
  }

  // Now scan all premium feature files
  final dir = Directory('packages/primecare_ui/lib/src/features/generated_screens');
  final premiumFiles = dir.listSync().whereType<File>().where((f) => f.path.contains('premium_feature_')).toList();

  print('Premium files: ${premiumFiles.length}');
  print('Registry entries: ${govMetadata.length}');

  // Match by parsing each premium file for title/subtitle/class
  final Map<String, String> matchedPremiumFiles = {};
  for (final file in premiumFiles) {
    final filename = file.path.split('/').last.split('\\').last;
    final fileContent = file.readAsStringSync();
    
    // Find class
    final classMatch = RegExp(r'class\s+([A-Za-z0-9_]+)\s+extends').firstMatch(fileContent);
    final className = classMatch?.group(1) ?? '';

    // Find title e.g. 'Premium Feature 111 - IoTEvent'
    final titleMatch = RegExp(r"title:\s*'([^']+)'").firstMatch(fileContent);
    final titleText = titleMatch?.group(1) ?? '';

    // If title has a suffix e.g. "IoTEvent", extract it
    String semanticName = '';
    if (titleText.contains(' - ')) {
      semanticName = titleText.split(' - ').last.trim();
    }

    // Now try to match semanticName or className or filename to govMetadata
    String? matchedKey;
    for (final entry in govMetadata.entries) {
      final key = entry.key;
      final metadata = entry.value;
      
      // Match if semanticName matches part of key or featureName or title
      if (semanticName.isNotEmpty) {
        final normSemantic = semanticName.toLowerCase().replaceAll(' ', '').replaceAll('_', '');
        final normKey = key.toLowerCase().replaceAll(' ', '').replaceAll('_', '').replaceAll('screen', '');
        final normFeature = metadata.featureName.toLowerCase().replaceAll(' ', '').replaceAll('_', '').replaceAll('screen', '');
        
        if (normKey.contains(normSemantic) || normSemantic.contains(normKey) ||
            normFeature.contains(normSemantic) || normSemantic.contains(normFeature)) {
          matchedKey = key;
          break;
        }
      }
    }

    if (matchedKey != null) {
      print('Matched file $filename ($className, "$titleText") -> Key: $matchedKey');
      matchedPremiumFiles[matchedKey] = className;
    }
  }

  print('\nTotal matched premium files: ${matchedPremiumFiles.length}');
}
