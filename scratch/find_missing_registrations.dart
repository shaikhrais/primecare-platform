
import 'dart:io';

void main() {
  final uiFeaturesPath = 'packages/factory_system/primecare_ui/lib/src/features';
  final registriesPath = 'packages/factory_system/primecare_ui/lib/src/shared/src/registry/domain_registries';

  final allViewFiles = Directory(uiFeaturesPath)
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('_view.dart'))
      .map((f) => f.path.replaceAll('\\', '/'))
      .toList();

  final registryFiles = Directory(registriesPath)
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('_registry.dart'))
      .toList();

  final Set<String> registeredFiles = {};

  for (final regFile in registryFiles) {
    final content = regFile.readAsStringSync();
    // Look for path or filename mentions
    // Most registries mention the route which often matches the folder name
    for (final viewFile in allViewFiles) {
      final fileName = viewFile.split('/').last.replaceAll('_view.dart', '');
      final folderName = viewFile.split('/').reversed.elementAt(1);
      
      if (content.contains(fileName) || content.contains(folderName)) {
        registeredFiles.add(viewFile);
      }
    }
  }

  print('Total View Files: ${allViewFiles.length}');
  print('Registered (heuristically): ${registeredFiles.length}');
  print('Missing: ${allViewFiles.length - registeredFiles.length}');

  final missing = allViewFiles.where((f) => !registeredFiles.contains(f)).toList();
  for (final m in missing) {
    print('MISSING: $m');
  }
}
