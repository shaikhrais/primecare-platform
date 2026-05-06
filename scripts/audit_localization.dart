import 'dart:io';

/// Audit localization setup across the PrimeCare platform.
/// This script verifies that all apps using EasyLocalization have valid asset paths
/// and that those paths are correctly registered in their respective pubspec.yaml files.
void main() {
  print('🔍 Starting Localization Audit...');
  final rootDir = Directory.current;
  final appsDir = Directory('${rootDir.path}/apps');

  if (!appsDir.existsSync()) {
    print('❌ Error: apps/ directory not found at ${appsDir.path}');
    exit(1);
  }

  var overallSuccess = true;

  for (final appDir in appsDir.listSync().whereType<Directory>()) {
    final appName = appDir.path.split('/').last.split('\\').last;
    if (appName.startsWith('.')) continue;

    print('\n--- Auditing: $appName ---');
    final success = auditApp(appDir);
    if (!success) overallSuccess = false;
  }

  if (overallSuccess) {
    print('\n✅ Localization Audit Passed! All apps are correctly configured.');
    exit(0);
  } else {
    print('\n❌ Localization Audit Failed! See errors above.');
    exit(1);
  }
}

bool auditApp(Directory appDir) {
  final pubspecFile = File('${appDir.path}/pubspec.yaml');
  final mainFile = File('${appDir.path}/lib/main.dart');

  if (!pubspecFile.existsSync()) {
    print('⚠️  Skipping: No pubspec.yaml found.');
    return true;
  }

  if (!mainFile.existsSync()) {
    print('⚠️  Skipping: No lib/main.dart found.');
    return true;
  }

  final pubspecContent = pubspecFile.readAsStringSync();
  if (!pubspecContent.contains('easy_localization:')) {
    print('ℹ️  Info: App does not appear to use easy_localization.');
    return true;
  }

  // 1. Extract path from main.dart
  final mainContent = mainFile.readAsStringSync();
  final pathRegex = RegExp(r"path:\s*['""]([^'""]+)['""]");
  final match = pathRegex.firstMatch(mainContent);

  if (match == null) {
    print('❌ Error: Could not find EasyLocalization path in main.dart');
    return false;
  }

  final i18nPath = match.group(1)!;
  print('📍 i18n Path: $i18nPath');

  if (i18nPath.startsWith('packages/')) {
    print('❌ Error: Non-normalized path detected. Use local "assets/translations" instead of package paths.');
    return false;
  }

  // 2. Verify physical path existence
  final physicalPath = '${appDir.path}/$i18nPath';
  final dir = Directory(physicalPath);
  if (!dir.existsSync()) {
    print('❌ Error: Physical translation directory does not exist: $physicalPath');
    return false;
  }

  final translationFiles = dir.listSync().where((f) => f.path.endsWith('.json')).toList();
  if (translationFiles.isEmpty) {
    print('❌ Error: No .json translation files found in $physicalPath');
    return false;
  }
  print('📂 Found ${translationFiles.length} translation files.');

  // 3. Verify pubspec.yaml registration
  if (!pubspecContent.contains(i18nPath)) {
    print('❌ Error: i18n path "$i18nPath" is not registered in pubspec.yaml assets.');
    return false;
  }

  print('✅ App localization setup is valid.');
  return true;
}
