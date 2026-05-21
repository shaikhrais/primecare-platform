import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  if (!file.existsSync()) {
    print('Core governance registry not found!');
    return;
  }

  final content = file.readAsStringSync();
  
  final screenBlockRegex = RegExp(
    r"'(\w+)':\s*ScreenMetadata\((.*?)\),",
    dotAll: true,
  );
  
  final matches = screenBlockRegex.allMatches(content);
  print('Found ${matches.length} screen metadata definitions in CoreGovernanceRegistry');

  int printed = 0;
  for (final match in matches) {
    final key = match.group(1)!;
    final block = match.group(2)!;
    
    final idMatch = RegExp(r"id:\s*'([^']+)'").firstMatch(block);
    final id = idMatch?.group(1) ?? 'Unknown';

    final featureNameMatch = RegExp(r"featureName:\s*'([^']*)'").firstMatch(block);
    final featureName = featureNameMatch?.group(1) ?? '';

    final titleMatch = RegExp(r"title:\s*'([^']*)'").firstMatch(block);
    final title = titleMatch?.group(1) ?? '';

    final routePathMatch = RegExp(r"routePath:\s*'([^']*)'").firstMatch(block);
    final routePath = routePathMatch?.group(1) ?? '';

    if (printed < 100 || key.contains('RMT') || key.contains('PREMIUM')) {
      print('Key: $key | ID: $id | FeatureName: $featureName | Title: $title | RoutePath: $routePath');
      printed++;
    }
  }
}
