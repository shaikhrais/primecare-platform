import 'dart:io';

void main() {
  final registryPath = 'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart';
  final uiRegistryPath = 'packages/primecare_ui/lib/src/registry/screen_registry.dart';

  final registryFile = File(registryPath);
  final uiFile = File(uiRegistryPath);

  if (!registryFile.existsSync()) {
    print('Error: CoreGovernanceRegistry not found!');
    return;
  }
  if (!uiFile.existsSync()) {
    print('Error: ScreenRegistry not found!');
    return;
  }

  // 1. Extract all screen IDs defined in core_governance_registry.dart
  final registryLines = registryFile.readAsLinesSync();
  final Set<String> registeredIds = {};
  final RegExp idRegExp = RegExp(r"^\s*'([A-Z0-9_]+)':\s*ScreenMetadata");
  
  for (final line in registryLines) {
    final match = idRegExp.firstMatch(line);
    if (match != null) {
      registeredIds.add(match.group(1)!);
    }
  }

  print('Total screens in CoreGovernanceRegistry: ${registeredIds.length}');

  // 2. Extract mappings from screen_registry.dart
  final uiLines = uiFile.readAsLinesSync();
  final Map<String, String> mappedScreens = {};
  
  for (final line in uiLines) {
    if (line.trim().startsWith("'") && (line.contains("': ") || line.contains("':\t"))) {
      final parts = line.split("':");
      if (parts.length >= 2) {
        final screenId = parts[0].trim().replaceAll("'", "").replaceAll('"', '');
        final impl = parts.sublist(1).join("':").trim().replaceAll(',', '');
        mappedScreens[screenId] = impl;
      }
    }
  }

  print('Total mappings in ScreenRegistry: ${mappedScreens.length}');

  // 3. Match registry IDs against mapped screens
  int implemented = 0;
  int missing = 0;
  int stubbed = 0;
  final List<String> missingIds = [];
  final List<String> stubbedIds = [];

  for (final id in registeredIds) {
    // Check both id and SCREEN_id
    final directImpl = mappedScreens[id];
    final screenPrefixedImpl = mappedScreens['SCREEN_$id'];
    
    final impl = directImpl ?? screenPrefixedImpl;
    if (impl == null) {
      missing++;
      missingIds.add(id);
    } else if (impl.contains('ScreenNotImplementedView') || impl.contains('CommonUiError404PageViewScreen')) {
      stubbed++;
      stubbedIds.add(id);
    } else {
      implemented++;
    }
  }

  print('\n--- Analysis Results ---');
  print('Total Registered: ${registeredIds.length}');
  print('Implemented:      $implemented');
  print('Stubbed/Placeholder: $stubbed');
  print('Missing Mappings: $missing');

  if (missingIds.isNotEmpty) {
    print('\nMissing IDs in screen_registry.dart:');
    for (final id in missingIds) {
      print(' - $id');
    }
  }

  if (stubbedIds.isNotEmpty) {
    print('\nStubbed/Placeholder IDs in screen_registry.dart:');
    for (final id in stubbedIds) {
      print(' - $id (Mapped to: ${mappedScreens[id] ?? mappedScreens['SCREEN_$id']})');
    }
  }
}
