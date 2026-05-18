import 'dart:io';

void main() {
  final content = File('packages/flutter_core/lib/routes/groups/franchise_routes.dart').readAsStringSync();
  final routeRegex = RegExp(r"'/offices/franchise/[a-zA-Z0-9_\-/]+'");
  final matches = routeRegex.allMatches(content);
  final routes = matches.map((m) => m.group(0)).toList();
  
  final code = '''
import 'dart:io';

const routes = [
  \${routes.join(',\\n  ')}
];

String toPascalCase(String text) {
  return text.split(RegExp(r'[-_]')).map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join('');
}

String toCamelCase(String text) {
  final parts = text.split(RegExp(r'[-_]'));
  if (parts.isEmpty) return '';
  final first = parts[0].toLowerCase();
  final rest = parts.skip(1).map((w) {
    if (w.isEmpty) return w;
    return w[0].toUpperCase() + w.substring(1);
  }).join('');
  return first + rest;
}

void main() {
  final outDir = Directory('apps/primecare_franchise/lib/features/franchise/presentation/widgets');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  final List<String> exports = [];

  for (final route in routes) {
    final parts = route.split('/');
    if (parts.length < 5) continue;
    final role = parts[4];
    final screen = parts[5];
    final className = toPascalCase(role) + toPascalCase(screen) + 'Screen';
    final fileName = role + '_' + screen.replaceAll('-', '_') + '_screen.dart';

    final code = "import 'package:flutter/material.dart';\\n" +
        "import 'package:primecare_ui/primecare_ui.dart';\\n\\n" +
        "class " + className + " extends StatelessWidget {\\n" +
        "  const " + className + "({super.key});\\n\\n" +
        "  @override\\n" +
        "  Widget build(BuildContext context) {\\n" +
        "    return EmptyState(\\n" +
        "      icon: LucideIcons.building,\\n" +
        "      title: '" + className + "',\\n" +
        "      subtitle: 'Franchise premium feature module pending hydration.',\\n" +
        "      actionLabel: 'Refresh',\\n" +
        "      onAction: () {},\\n" +
        "    );\\n" +
        "  }\\n" +
        "}\\n";
    File(outDir.path + '/' + fileName).writeAsStringSync(code);
    exports.add("export '" + fileName + "';");
  }
  File(outDir.path + '/widgets.dart').writeAsStringSync(exports.join('\\n') + '\\n');
  
  // Now generate the routes file
  final Map<String, List<String>> roleToRoutes = {};
  for (var r in routes) {
    if (r.trim().isEmpty) continue;
    final parts = r.split('/');
    if (parts.length < 5) continue;
    final role = parts[4];
    roleToRoutes.putIfAbsent(role, () => []).add(r);
  }

  String fileCode = "import 'package:primecare_ui/primecare_ui.dart' hide ShareholderDashboardScreen, FinanceDirectorDashboardScreen, VolunteerCoordinatorDashboardScreen, HrManagerDashboardScreen, HrHiringDashboardScreen, HrDirectorDashboardScreen, CxDirectorDashboardScreen, LegalDashboardScreen, CisoDashboardScreen, OwnerDashboardScreen, CooDashboardScreen, CfoDashboardScreen, CtoDashboardScreen, ComplianceManagerDashboardScreen, HeadOfBusDevDashboardScreen, HeadOfMarketingDashboardScreen, TrainingDirectorDashboardScreen;\\n" +
      "import '../../features/franchise/presentation/widgets/widgets.dart';\\n\\n" +
      "class PrimeCareTenant extends PlatformTenant {\\n" +
      "  @override\\n" +
      "  String get id => 'primecare';\\n" +
      "  @override\\n" +
      "  String get name => 'PrimeCare';\\n" +
      "  @override\\n" +
      "  ThemeData get theme => const PrimeThemeData(\\n" +
      "        primaryColor: Color(0xFF003366),\\n" +
      "        accentColor: Color(0xFF0066CC),\\n" +
      "      ).toThemeData();\\n" +
      "}\\n\\n";

  roleToRoutes.forEach((role, routeList) {
    if (role.trim().isEmpty) return;
    String modClass = toPascalCase(role) + "Module";
    String platRole = "PlatformRole." + toCamelCase(role);
    
    fileCode += "\\nclass \$modClass extends PlatformModule {\\n" +
        "  @override\\n" +
        "  String get moduleId => '\${role}_module';\\n\\n" +
        "  @override\\n" +
        "  String get name => '\${toPascalCase(role)} Dashboard';\\n\\n" +
        "  @override\\n" +
        "  IconData get icon => Icons.admin_panel_settings;\\n\\n" +
        "  @override\\n" +
        "  List<PlatformRole> get allowedRoles => [\$platRole];\\n\\n" +
        "  @override\\n" +
        "  List<PrimeCareScreen> get screens => [\\n";

    for (var route in routeList) {
      if (route.trim().isEmpty) continue;
      final parts = route.split('/');
      final screen = parts[5];
      final className = toPascalCase(role) + toPascalCase(screen) + 'Screen';
      final screenTitle = toPascalCase(screen).replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (m) => " " + m.group(0)!);
      String routeProp = toCamelCase(role) + toPascalCase(screen);
      fileCode += "    PrimeCareScreen(\\n" +
          "      title: '\$screenTitle',\\n" +
          "      route: FranchiseRoutes.\$routeProp,\\n" +
          "      builder: (context) => const \$className(),\\n" +
          "    ),\\n";
    }

    fileCode += "  ];\\n}\\n";
  });

  fileCode += "\\nclass FranchiseApplication extends PlatformApplication {\\n" +
      "  @override\\n" +
      "  String get appId => 'primecare_franchise';\\n" +
      "  @override\\n" +
      "  String get name => 'PrimeCare Franchise Portal';\\n" +
      "  String get homeRoute => FranchiseRoutes.franchiseOwnerDashboard;\\n" +
      "  @override\\n" +
      "  PlatformTenant get tenant => PrimeCareTenant();\\n\\n" +
      "  @override\\n" +
      "  List<PlatformRoleDefinition> get roleDefinitions => [\\n";

  roleToRoutes.forEach((role, routeList) {
    if (role.trim().isEmpty) return;
    String modClass = toPascalCase(role) + "Module";
    String platRole = "PlatformRole." + toCamelCase(role);
    String dbRoute = routeList.firstWhere((r) => r.endsWith('dashboard'), orElse: () => routeList.first);
    final parts = dbRoute.split('/');
    final screen = parts[5];
    String routeProp = toCamelCase(role) + toPascalCase(screen);
    final fullRouteProp = "FranchiseRoutes." + routeProp;

    fileCode += "    PlatformRoleDefinition(\\n" +
        "      role: \$platRole,\\n" +
        "      dashboardRoute: \$fullRouteProp,\\n" +
        "      modules: [\$modClass()],\\n" +
        "    ),\\n";
  });

  fileCode += "  ];\\n}\\n";

  final fileOut = File('apps/primecare_franchise/lib/core/routing/franchise_routes.dart');
  if(!fileOut.existsSync()) {
      fileOut.createSync(recursive: true);
  }
  fileOut.writeAsStringSync(fileCode);
}
''';

  File('scratch/gen_franchise.dart').writeAsStringSync(code);
  print('Generated scratch/gen_franchise.dart');
}
