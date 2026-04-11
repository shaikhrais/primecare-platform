import 'dart:io';

void main() async {
  final appsDir = Directory(
    'c:/Users/Admin2/Documents/GitHub/primecare-platform/apps',
  );
  final routesFiles = appsDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.contains('routes.dart'))
      .toList();

  int bdevCounter = 601;
  int corpCounter = 701;
  int franCounter = 801;
  int mrktCounter = 901;

  final Map<String, List<String>> entries = {
    'business_development': [],
    'corporate': [],
    'franchise': [],
    'marketing': [],
  };

  for (var file in routesFiles) {
    if (file.path.contains('business_development')) {
      entries['business_development']!.addAll(
        _parseFile(file, 'BDV', () => bdevCounter++),
      );
    } else if (file.path.contains('corporate')) {
      entries['corporate']!.addAll(
        _parseFile(file, 'COR', () => corpCounter++),
      );
    } else if (file.path.contains('franchise') &&
        !file.path.contains(
          'primecare_franchise\\lib\\routes\\app_routes.dart',
        )) {
      // Avoid parsing the main app_routes.dart if it exists. We only want groups
      if (file.path.contains('groups')) {
        entries['franchise']!.addAll(
          _parseFile(file, 'FRA', () => franCounter++),
        );
      }
    } else if (file.path.contains('marketing')) {
      entries['marketing']!.addAll(
        _parseFile(file, 'MKT', () => mrktCounter++),
      );
    }
  }

  // Open the master registry and append these sections
  final registryFile = File(
    'C:/Users/Admin2/.gemini/antigravity/brain/70a810e6-ca4a-4160-9177-5b90c9067836/master_screen_registry.md',
  );
  String content = registryFile.readAsStringSync();

  // Remove the old Phase 2 section
  content = content.split('### Phase 2 Domains (Discovery Pending)')[0];

  final sb = StringBuffer();
  sb.writeln('### Series 600: Business Development Screens');
  sb.writeln(
    '| Serial Code | Identified Route Path | Target Widget Component | Status |',
  );
  sb.writeln(
    '| :---------- | :-------------------- | :---------------------- | :----- |',
  );
  for (var e in entries['business_development']!) {
    sb.writeln(e);
  }
  sb.writeln('');

  sb.writeln('### Series 700: Corporate Screens');
  sb.writeln(
    '| Serial Code | Identified Route Path | Target Widget Component | Status |',
  );
  sb.writeln(
    '| :---------- | :-------------------- | :---------------------- | :----- |',
  );
  for (var e in entries['corporate']!) {
    sb.writeln(e);
  }
  sb.writeln('');

  sb.writeln('### Series 800: Franchise Screens');
  sb.writeln(
    '| Serial Code | Identified Route Path | Target Widget Component | Status |',
  );
  sb.writeln(
    '| :---------- | :-------------------- | :---------------------- | :----- |',
  );
  for (var e in entries['franchise']!) {
    sb.writeln(e);
  }
  sb.writeln('');

  sb.writeln('### Series 900: Marketing Screens');
  sb.writeln(
    '| Serial Code | Identified Route Path | Target Widget Component | Status |',
  );
  sb.writeln(
    '| :---------- | :-------------------- | :---------------------- | :----- |',
  );
  for (var e in entries['marketing']!) {
    sb.writeln(e);
  }
  sb.writeln('');

  sb.writeln('---');
  sb.writeln(
    '*Registry automatically synchronized based on physical routing schemas.*',
  );

  registryFile.writeAsStringSync(content + sb.toString());
  print(
    'Registry updated successfully. Added BDV: \${entries["business_development"]!.length}, COR: \${entries["corporate"]!.length}, FRA: \${entries["franchise"]!.length}, MKT: \${entries["marketing"]!.length}',
  );
}

List<String> _parseFile(File file, String prefix, int Function() getCounter) {
  final content = file.readAsStringSync();
  final routeRegex = RegExp(
    r'GoRoute\(\s*path:\s*(AppRoutes\.[a-zA-Z0-9_]+),\s*builder:\s*\(context,\s*state\)\s*=>\s*const\s*([a-zA-Z0-9_\.]+)\((.*?)\),\s*\)',
  );

  final List<String> results = [];
  final matches = routeRegex.allMatches(content);
  for (var match in matches) {
    final routePath = match.group(1);
    final component = match.group(2);
    final status = component!.contains('GenericFeatureScreen')
        ? 'Discovery'
        : 'Discovery(Implemented)';
    results.add(
      '| ${prefix}-${getCounter()} | `${routePath}` | `${component}` | ${status} |',
    );
  }
  return results;
}
