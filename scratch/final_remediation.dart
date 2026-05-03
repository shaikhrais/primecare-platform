import 'dart:io';

void main() async {
  final List<String> targets = [
    'SCREEN_IT_SECURITY_DASHBOARD',
    'SCREEN_ERROR_401',
    'SCREEN_ERROR_404',
    'SCREEN_SIGN_IN',
    'SCREEN_SIGN_OUT',
    'SCREEN_SIGN_UP',
    'SCREEN_ARCHITECTURAL_PLANNING',
    'SCREEN_COURSE_ARCHITECT_DASHBOARD',
    'SCREEN_DYNAMIC_ROLE_DASHBOARD',
    'SCREEN_DYNAMIC_SCREEN_DASHBOARD',
    'SCREEN_FEATURES_EXPLORER',
    'SCREEN_REGIONAL_BDM_DASHBOARD',
    'SCREEN_FAMILY_DASHBOARD',
    'SCREEN_PATIENT_DASHBOARD',
    'SCREEN_CLINIC_DASHBOARD',
    'SCREEN_GUEST_DASHBOARD',
  ];

  final registryDir = Directory('apps/primecare_governance/lib/core/governance/registries');
  final registryFiles = registryDir.listSync().whereType<File>().where((f) => f.path.endsWith('_registry.dart'));

  final uiBase = 'packages/factory_system/primecare_ui/lib/src/features';

  for (final target in targets) {
    print('Processing $target...');
    
    // 1. Get registry metadata
    String? sourcePath;
    List<String>? expectedComponents;
    
    for (final file in registryFiles) {
      final content = file.readAsStringSync();
      final match = RegExp("'$target': ScreenMetadata\\(([\\s\\S]*?)\\),").firstMatch(content);
      if (match != null) {
        final body = match.group(1)!;
        sourcePath = RegExp(r"sourcePath:\s*'([^']+)'").firstMatch(body)?.group(1);
        final compMatch = RegExp(r"implementedComponents:\s*\[([\s\S]*?)\]").firstMatch(body);
        if (compMatch != null) {
          expectedComponents = compMatch.group(1)!.split(',').map((e) => e.trim().replaceAll("'", "").replaceAll('"', "")).toList();
        }
        break;
      }
    }

    if (sourcePath == null || expectedComponents == null) {
      print('  Error: Could not find registry data for $target');
      continue;
    }

    // 2. Locate file
    final files = Directory(uiBase).listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith(sourcePath!)).toList();
    if (files.isEmpty) {
      print('  Error: Could not find code file for $sourcePath');
      continue;
    }

    final file = files.first;
    String code = file.readAsStringSync();

    // 3. Update Intent class componentLabels
    final componentsStr = expectedComponents.map((c) => "'$c'").join(', ');
    final intentRegex = RegExp(r'(class \w+Intent extends PrimeCareScreen \{[\s\S]*?componentLabels: const \[)(.*?)(\],)');
    
    if (intentRegex.hasMatch(code)) {
      code = code.replaceFirst(intentRegex, '${intentRegex.firstMatch(code)!.group(1)}$componentsStr${intentRegex.firstMatch(code)!.group(3)}');
      file.writeAsStringSync(code);
      print('  Success: Updated Intent for $target');
    } else {
      print('  Warning: Could not find Intent class in ${file.path}');
    }
  }
}
