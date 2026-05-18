import 'dart:io';

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
  final content = File('packages/flutter_core/lib/routes/groups/franchise_routes.dart').readAsStringSync();
  final routeRegex = RegExp(r"'/offices/franchise/[a-zA-Z0-9_\-/]+'");
  final routes = routeRegex.allMatches(content).map((m) => m.group(0)!.replaceAll("'", "")).toList();
  
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

    final code = '''import 'package:primecare_ui/primecare_ui.dart';

class $className extends StatelessWidget {
  const $className({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.building,
      title: '$className',
      subtitle: 'Franchise premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
''';
    File(outDir.path + '/' + fileName).writeAsStringSync(code);
    exports.add("export '" + fileName + "';");
  }
  File(outDir.path + '/widgets.dart').writeAsStringSync(exports.join('\n') + '\n');
  
  // Now generate the routes file
  final Map<String, List<String>> roleToRoutes = {};
  for (var r in routes) {
    if (r.trim().isEmpty) continue;
    final parts = r.split('/');
    if (parts.length < 5) continue;
    final role = parts[4];
    roleToRoutes.putIfAbsent(role, () => []).add(r);
  }

  String fileCode = '''import 'package:primecare_ui/primecare_ui.dart' hide HrHiringDashboardScreen;
import 'package:flutter_core/flutter_core.dart';
import '../../features/franchise/presentation/widgets/widgets.dart';

''';

  roleToRoutes.forEach((role, routeList) {
    if (role.trim().isEmpty) return;
    String modClass = toPascalCase(role) + "Module";
    String platRole = "PlatformRole." + toCamelCase(role);
    
    if (role == 'admin') platRole = 'PlatformRole.itAdmin';
    if (role == 'scheduler_coordinator') platRole = 'PlatformRole.scheduler';
    if (role == 'hr_hiring') platRole = 'PlatformRole.hrHiring';
    if (role == 'regional_manager') platRole = 'PlatformRole.regionalManagerOntario'; // fallback
    if (role == 'marketing_manager') platRole = 'PlatformRole.localMarketingManager';
    if (role == 'billing_admin') platRole = 'PlatformRole.billingAdmin';
    if (role == 'operations_manager') platRole = 'PlatformRole.operationsManager';
    if (role == 'franchise_owner') platRole = 'PlatformRole.franchiseOwner';
    
    fileCode += '''class $modClass extends PlatformModule {
  @override
  String get moduleId => '${role}_module';

  @override
  String get name => '${toPascalCase(role)} Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [$platRole];

  @override
  List<PrimeCareScreen> get screens => [
''';

    for (var route in routeList) {
      if (route.trim().isEmpty) continue;
      final parts = route.split('/');
      final screen = parts[5];
      final className = toPascalCase(role) + toPascalCase(screen) + 'Screen';
      final screenTitle = toPascalCase(screen).replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (m) => " " + m.group(0)!);
      String routeProp = toCamelCase(role) + toPascalCase(screen);
      fileCode += '''    PrimeCareScreen(
      title: '$screenTitle',
      route: FranchiseRoutes.$routeProp,
      builder: (context) => const $className(),
    ),
''';
    }

    fileCode += "  ];\n}\n\n";
  });

  fileCode += '''class FranchiseApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_franchise';
  @override
  String get name => 'PrimeCare Franchise Portal';
  String get homeRoute => FranchiseRoutes.franchiseOwnerDashboard;
  @override
  PlatformTenant get tenant => PrimeCareTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
''';

  roleToRoutes.forEach((role, routeList) {
    if (role.trim().isEmpty) return;
    String modClass = toPascalCase(role) + "Module";
    String platRole = "PlatformRole." + toCamelCase(role);
    
    if (role == 'admin') platRole = 'PlatformRole.itAdmin';
    if (role == 'scheduler_coordinator') platRole = 'PlatformRole.scheduler';
    if (role == 'hr_hiring') platRole = 'PlatformRole.hrHiring';
    if (role == 'regional_manager') platRole = 'PlatformRole.regionalManagerOntario'; // fallback
    if (role == 'marketing_manager') platRole = 'PlatformRole.localMarketingManager';
    if (role == 'billing_admin') platRole = 'PlatformRole.billingAdmin';
    if (role == 'operations_manager') platRole = 'PlatformRole.operationsManager';
    if (role == 'franchise_owner') platRole = 'PlatformRole.franchiseOwner';

    String dbRoute = routeList.firstWhere((r) => r.endsWith('dashboard'), orElse: () => routeList.first);
    final parts = dbRoute.split('/');
    final screen = parts[5];
    String routeProp = toCamelCase(role) + toPascalCase(screen);
    final fullRouteProp = "FranchiseRoutes." + routeProp;

    fileCode += '''    PlatformRoleDefinition(
      role: $platRole,
      dashboardRoute: $fullRouteProp,
      modules: [$modClass()],
    ),
''';
  });

  fileCode += "  ];\n}\n";

  final fileOut = File('apps/primecare_franchise/lib/core/routing/franchise_routes.dart');
  if(!fileOut.existsSync()) {
      fileOut.createSync(recursive: true);
  }
  fileOut.writeAsStringSync(fileCode);
}
