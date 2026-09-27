// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE 1. Get all ViewModels from Domain 2. Get all Adapters from Domain 3. Get all Intents from Core
// Layer: 01_INFRASTRUCTURE
import 'dart:io';

void main() {
  final projectRoot = Directory.current.path;
  final adaptersRoot = '$projectRoot/packages/primecare_adapters/lib/src';
  final coreFeaturesRoot = '$projectRoot/packages/flutter_core/lib/features';

  // 1. Get all ViewModels from Domain
  final viewModels = _scanForPattern(
    Directory(adaptersRoot),
    '_view_model.dart',
  ).map((p) => _normalize(p, '_view_model.dart')).toSet();

  // 2. Get all Adapters from Domain
  final adapters = _scanForPattern(
    Directory(adaptersRoot),
    '_adapter.dart',
  ).map((p) => _normalize(p, '_adapter.dart')).toSet();

  // 3. Get all Intents from Core
  final intents = _scanForPattern(
    Directory(coreFeaturesRoot),
    '_intent.dart',
  ).map((p) => _normalize(p, '_intent.dart')).toSet();

  // 4. Get all Screens from Core
  final screens = _scanForPattern(
    Directory(coreFeaturesRoot),
    '_screen.dart',
  ).map((p) => _normalize(p, '_screen.dart')).toSet();

  final allRoles = {...viewModels, ...adapters, ...intents, ...screens};

  print('# PrimeCare Platform Realization Matrix');
  print(
    '| Feature/Role | Domain Model | Domain Adapter | Core Intent | Core Screen | Status |',
  );
  print('| :--- | :---: | :---: | :---: | :---: | :--- |');

  final sortedRoles = allRoles.toList()..sort();

  for (final role in sortedRoles) {
    final hasVM = viewModels.contains(role);
    final hasAdapter = adapters.contains(role);
    final hasIntent = intents.contains(role);
    final hasScreen = screens.contains(role);

    final status = _calculateStatus(hasVM, hasAdapter, hasIntent, hasScreen);

    print(
      '| $role | ${hasVM ? "✅" : "❌"} | ${hasAdapter ? "✅" : "❌"} | ${hasIntent ? "✅" : "❌"} | ${hasScreen ? "✅" : "❌"} | $status |',
    );
  }
}

String _normalize(String path, String suffix) {
  final fileName = path.split('\\').last.split('/').last;
  return fileName
      .replaceAll('03_V_', '')
      .replaceAll('04_A_', '')
      .replaceAll('05_U_', '')
      .replaceAll('_dashboard', '')
      .replaceAll(suffix, '');
}

List<String> _scanForPattern(Directory dir, String pattern) {
  if (!dir.existsSync()) return [];
  return dir
      .listSync(recursive: true)
      .where((f) => f.path.endsWith(pattern))
      .map((f) => f.path)
      .toList();
}

String _calculateStatus(bool vm, bool adp, bool intent, bool screen) {
  if (vm && adp && intent && screen) return '**DONE**';
  if (vm && adp && intent) return 'Missing UI';
  if (vm && adp) return 'Domain Only';
  if (intent && screen) return 'Mocked UI';
  return 'Incomplete';
}
