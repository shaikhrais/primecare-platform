import 'dart:io';

void main() {
  final offices = ['HO', 'BD', 'FL', 'CT', 'ST', 'MG', 'CS'];
  final roles = ['psw', 'rn', 'client', 'family_member', 'territory_sales_manager'];
  
  StringBuffer imports = StringBuffer();
  StringBuffer routes = StringBuffer();

  imports.writeln("import 'package:flutter/material.dart';");
  imports.writeln("import 'package:go_router/go_router.dart';");
  // Assumes a general error block or root redirect
  
  for (final office in offices) {
    for (final role in roles) {
      imports.writeln("import '../modules/offices/\$office/\$role/\${role}_layout.dart';");
      imports.writeln("import '../modules/offices/\$office/\$role/\${role}_dashboard.dart';");
      imports.writeln("import '../modules/offices/\$office/\$role/\${role}_settings.dart';");
      
      String titleCaseRole = role[0].toUpperCase() + role.substring(1).toLowerCase();
      String classNamePrefix = "\${titleCaseRole}";
      
      routes.writeln('''
      ShellRoute(
        builder: (context, state, child) {
          return \${classNamePrefix}LayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: '/\${office.toLowerCase()}/\$role/dashboard',
             builder: (_, __) => const \${classNamePrefix}DashboardWidget(),
           ),
           GoRoute(
             path: '/\${office.toLowerCase()}/\$role/settings',
             builder: (_, __) => const \${classNamePrefix}SettingsWidget(),
           ),
        ],
      ),''');
    }
  }

  String fileContent = '''
\$imports

final router = GoRouter(
  initialLocation: '/ho/psw/dashboard',
  routes: [
\$routes
  ],
);
''';

  File('lib/core/app_router.dart').writeAsStringSync(fileContent);
  print('Successfully generated app_router.dart binding 35 ShellRoutes and 70 distinct screens.');
}
