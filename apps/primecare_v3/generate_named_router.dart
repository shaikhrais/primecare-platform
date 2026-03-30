import 'dart:io';

void main() {
  final offices = [
    'corporate_head_office',
    'business_development_team',
    'franchise_level',
    'clinical_team',
    'support_team',
    'marketing_local_growth',
    'client_side'
  ];
  
  StringBuffer imports = StringBuffer();
  StringBuffer routes = StringBuffer();

  imports.writeln("import 'package:flutter/material.dart';");
  imports.writeln("import 'package:go_router/go_router.dart';");
  imports.writeln("import '../core/forms/form_renderer_adapter.dart';");
  
  for (final folder in offices) {
      imports.writeln("import '../modules/offices/\$folder/\${folder}_layout.dart';");
      imports.writeln("import '../modules/offices/\$folder/\${folder}_dashboard.dart';");
      imports.writeln("import '../modules/offices/\$folder/\${folder}_settings.dart';");
      
      String titleCasePrefix = folder.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join('');
      
      routes.writeln('''
      ShellRoute(
        builder: (context, state, child) {
          return \${titleCasePrefix}LayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: '/\$folder/dashboard',
             builder: (_, __) => const \${titleCasePrefix}DashboardWidget(),
           ),
           GoRoute(
             path: '/\$folder/settings',
             builder: (_, __) => const \${titleCasePrefix}SettingsWidget(),
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
  initialLocation: '/corporate_head_office/dashboard',
  routes: [
\$routes
  ],
);
''';

  File('lib/core/app_router.dart').writeAsStringSync(fileContent);
  print('Successfully rebuilt app_router.dart integrating Named Architecture.');
}
