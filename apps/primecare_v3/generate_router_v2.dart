import 'dart:io';

void main() {
  final standardOffices = ['HO', 'BD', 'FL', 'CT', 'ST', 'MG', 'CS'];
  final standardRoles = ['psw', 'rn', 'client', 'family_member', 'territory_sales_manager'];
  
  final franchiseOffice = 'FR';
  final franchiseRoles = ['clinical_team', 'support_team', 'marketing_local_growth', 'client_side', 'business_development'];
  
  StringBuffer imports = StringBuffer();
  StringBuffer routes = StringBuffer();

  imports.writeln("import 'package:flutter/material.dart';");
  imports.writeln("import 'package:go_router/go_router.dart';");
  imports.writeln("import '../core/forms/form_renderer_adapter.dart';");
  
  // 1. Standard Offices
  for (final office in standardOffices) {
    for (final role in standardRoles) {
      imports.writeln("import '../modules/offices/\$office/\$role/\${role}_layout.dart';");
      imports.writeln("import '../modules/offices/\$office/\$role/\${role}_dashboard.dart';");
      imports.writeln("import '../modules/offices/\$office/\$role/\${role}_settings.dart';");
      
      String titleCaseRole = role[0].toUpperCase() + role.substring(1).toLowerCase();
      
      routes.writeln('''
      ShellRoute(
        builder: (context, state, child) {
          return \${titleCaseRole}LayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: '/\${office.toLowerCase()}/\$role/dashboard',
             builder: (_, __) => const \${titleCaseRole}DashboardWidget(),
           ),
           GoRoute(
             path: '/${office.toLowerCase()}/$role/settings',
             builder: (_, __) => const ${titleCaseRole}SettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),''');
    }
  }

  // 2. Franchise Offices
  for (final role in franchiseRoles) {
      imports.writeln("import '../modules/offices/FR/$role/${role}_layout.dart';");
      imports.writeln("import '../modules/offices/FR/$role/${role}_dashboard.dart';");
      imports.writeln("import '../modules/offices/FR/$role/${role}_settings.dart';");
      
      String titleCaseRole = role.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join('');
      
      routes.writeln('''
      ShellRoute(
        builder: (context, state, child) {
          return \${titleCaseRole}LayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: '/fr/$role/dashboard',
             builder: (_, __) => const \${titleCaseRole}DashboardWidget(),
           ),
           GoRoute(
             path: '/fr/$role/settings',
             builder: (_, __) => const ${titleCaseRole}SettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),''');
  }

  String fileContent = '''
\$imports

final router = GoRouter(
  initialLocation: '/fr/clinical_team/dashboard',
  routes: [
\$routes
  ],
);
''';

  File('lib/core/app_router.dart').writeAsStringSync(fileContent);
  print('Successfully rebuilt app_router.dart integrating Franchise dynamically.');
}
