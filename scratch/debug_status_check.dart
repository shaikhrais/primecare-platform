import 'dart:io';

void main() {
  final uiRegistryPath = 'packages/primecare_ui/lib/src/registry/screen_registry.dart';
  final file = File(uiRegistryPath);
  
  final Set<String> registryPending = {};
  final Set<String> registryImplemented = {};

  if (file.existsSync()) {
    final lines = file.readAsLinesSync();
    for (final line in lines) {
      if (line.trim().startsWith("'") &&
          (line.contains("': ") || line.contains("':\t"))) {
        final parts = line.split("':");
        if (parts.length >= 2) {
          final screenIdStr = parts[0].trim();
          final screenId = screenIdStr.replaceAll('\'', '').replaceAll('"', '');
          final implementation = parts.sublist(1).join("':").trim();

          if (implementation.startsWith('CommonUiError404PageViewScreen')) {
            registryPending.add(screenId);
          } else {
            registryImplemented.add(screenId);
          }
        }
      }
    }
  }

  print('Total parsed from registry:');
  print('  Implemented size: ${registryImplemented.length}');
  print('  Pending size: ${registryPending.length}');
  print('\nFirst 20 Implemented in Registry:');
  print(registryImplemented.take(20).toList());
}
