import 'dart:io';

void main() {
  final govFile = File(
    'apps/primecare_governance/lib/core/governance/registries/workflows_forms_registry.dart',
  );
  final uiFile = File(
    'packages/factory_system/primecare_ui/lib/src/shared/src/registry/domain_registries/workflows_forms_registry.dart',
  );

  final govContent = govFile.readAsStringSync();

  // Extract all screen IDs and route paths
  final idRegex = RegExp(r"'([A-Z0-9_]+)': const ScreenMetadata\(");
  final routeRegex = RegExp(r"routePath: '([^']+)'");
  final titleRegex = RegExp(r"title: '([^']+)'");

  final ids = idRegex.allMatches(govContent).map((m) => m.group(1)!).toList();
  final routes = routeRegex
      .allMatches(govContent)
      .map((m) => m.group(1)!)
      .toList();
  final titles = titleRegex
      .allMatches(govContent)
      .map((m) => m.group(1)!)
      .toList();

  final sb = StringBuffer();
  sb.writeln("import 'package:primecare_ui/primecare_ui.dart';");
  sb.writeln("import '../office_screen_registry.dart';");
  sb.writeln("");
  sb.writeln("class WorkflowsFormsRegistry extends OfficeScreenRegistry {");
  sb.writeln("  @override");
  sb.writeln("  void bootstrap() {");
  sb.writeln("    _registerMetadataScreens();");
  sb.writeln("  }");
  sb.writeln("");
  sb.writeln("  void _registerMetadataScreens() {");

  for (int i = 0; i < ids.length; i++) {
    sb.writeln("    registerRoute(");
    sb.writeln("      '${routes[i]}',");
    sb.writeln("      PrimeCareForm.genericDashboard,");
    sb.writeln("      titleKey: '${titles[i]}',");
    sb.writeln(
      "      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],",
    );
    sb.writeln("    );");
  }

  sb.writeln("  }");
  sb.writeln("");
  sb.writeln("  @override");
  sb.writeln("  Map<String, Map<String, dynamic>> get registryJson => {");

  for (int i = 0; i < ids.length; i++) {
    sb.writeln("    '${ids[i]}': {");
    sb.writeln("      'title': '${titles[i]}',");
    sb.writeln("      'path': '${routes[i]}',");
    sb.writeln(
      "      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],",
    );
    sb.writeln("    },");
  }

  sb.writeln("  };");
  sb.writeln("}");

  uiFile.writeAsStringSync(sb.toString());
  print(
    'Generated WorkflowsFormsRegistry for primecare_ui with ${ids.length} screens.',
  );
}
