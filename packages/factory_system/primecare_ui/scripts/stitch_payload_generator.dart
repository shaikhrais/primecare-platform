import 'dart:io';
import 'package:primecare_ui/src/screen_registry.dart';

/// The Stitch Payload Generator.
/// It extracts the technical "DNA" of a screen to ensure high-fidelity generation.
void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart stitch_payload_generator.dart <route>');
    return;
  }

  final route = args[0];
  final metadata = ScreenRegistry.allScreens.firstWhere(
    (s) => s.route == route || s.name == route,
    orElse: () => throw Exception('Screen not found in registry: $route'),
  );

  print('### TECHNICAL SPECI FOR ${metadata.name}');
  print('\n#### 1. REGISTRY METADATA');
  print('- Route: ${metadata.route}');
  print('- Domain: ${metadata.domain}');
  print('- Role: ${metadata.role}');
  print('- Mandatory Components: ${metadata.mandatoryComponents.join(", ")}');

  print('\n#### 2. COMPONENT SOURCE INJECTION');
  for (final component in metadata.mandatoryComponents) {
    _injectComponentSource(component);
  }

  print('\n#### 3. RESPONSIVE CONTRACT');
  print('- Ultra (4K): 12-column grid, density=2.0, fontScale=1.5');
  print('- Desktop (1080p): 8-column grid, density=1.0, fontScale=1.0');
  print('- Mobile: 1-column stack, Drawer navigation, Bottom Sheet actions');

  print('\n#### 4. AESTHETIC DIRECTIVE (AURA VISION V4)');
  print('- Background: surface_container_lowest with 40px BackdropBlur');
  print('- Border: 1px Ghost Border (white at 10% opacity)');
  print('- Spacing: No-line partitioning. Use HSL tonal shifts for depth.');
}

void _injectComponentSource(String componentName) {
  final possiblePaths = [
    'lib/src/shared/src/core/${_toSnakeCase(componentName)}.dart',
    'lib/src/shared/src/components/dashboard/${_toSnakeCase(componentName)}.dart',
    'lib/src/shared/src/core/primecare_components.dart',
  ];

  for (final path in possiblePaths) {
    final file = File(path);
    if (file.existsSync()) {
      print('\n##### SOURCE: $componentName ($path)');
      print('```dart');
      // Only take the first 50 lines to avoid prompt bloat, focusing on the class definition and constructor.
      final lines = file.readAsLinesSync();
      final snippet = lines.length > 50 ? lines.sublist(0, 50).join('\n') : lines.join('\n');
      print(snippet);
      print('```');
      return;
    }
  }
  print('\n> [!WARNING]\n> Source for $componentName not found in standard paths.');
}

String _toSnakeCase(String name) {
  return name.replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (Match m) => '${m.group(1)}_${m.group(2)}').toLowerCase();
}
