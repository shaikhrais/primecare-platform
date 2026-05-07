import 'dart:io';

void main() {
  print('🚀 Starting Platform-wide Localization Normalization...');
  final rootDir = Directory.current;
  final appsDir = Directory('${rootDir.path}/apps');
  final sourceTranslations = Directory(
    '${rootDir.path}/packages/flutter_core/assets/translations',
  );

  if (!sourceTranslations.existsSync()) {
    print('❌ Error: Source translations not found in flutter_core.');
    exit(1);
  }

  for (final appDir in appsDir.listSync().whereType<Directory>()) {
    final appName = appDir.path.split('/').last.split('\\').last;
    if (appName.startsWith('.')) continue;

    print('\n--- Normalizing: $appName ---');
    normalizeApp(appDir, sourceTranslations);
  }

  print('\n✅ Normalization Complete!');
}

void normalizeApp(Directory appDir, Directory sourceTranslations) {
  final pubspecFile = File('${appDir.path}/pubspec.yaml');
  final mainFile = File('${appDir.path}/lib/main.dart');

  if (!pubspecFile.existsSync() || !mainFile.existsSync()) {
    print('⚠️  Skipping: Missing pubspec.yaml or main.dart');
    return;
  }

  final mainContent = mainFile.readAsStringSync();
  if (!mainContent.contains('EasyLocalization')) return;

  // 1. Create local assets/translations directory
  final targetTranslations = Directory('${appDir.path}/assets/translations');
  if (!targetTranslations.existsSync()) {
    targetTranslations.createSync(recursive: true);
    print('📂 Created assets/translations');
  }

  // 2. Copy translation files
  for (final file in sourceTranslations.listSync().whereType<File>()) {
    final fileName = file.path.split('/').last.split('\\').last;
    file.copySync('${targetTranslations.path}/$fileName');
  }
  print('📄 Copied translation files');

  // 3. Update main.dart path
  var newMainContent = mainContent.replaceAll(
    'packages/flutter_core/assets/translations',
    'assets/translations',
  );
  if (newMainContent != mainContent) {
    mainFile.writeAsStringSync(newMainContent);
    print('📝 Updated main.dart path');
  }

  // 4. Update pubspec.yaml assets
  var pubspecContent = pubspecFile.readAsStringSync();
  if (!pubspecContent.contains('assets/translations/')) {
    // Find the assets: section
    if (pubspecContent.contains('assets:')) {
      newMainContent = pubspecContent.replaceFirst(
        'assets:',
        'assets:\n    - assets/translations/',
      );
    } else {
      // Add flutter: and assets: if missing (less likely but possible)
      if (pubspecContent.contains('flutter:')) {
        newMainContent = pubspecContent.replaceFirst(
          'flutter:',
          'flutter:\n  assets:\n    - assets/translations/',
        );
      }
    }

    if (newMainContent != pubspecContent) {
      pubspecFile.writeAsStringSync(newMainContent);
      print('📝 Updated pubspec.yaml assets');
    }
  }
}
