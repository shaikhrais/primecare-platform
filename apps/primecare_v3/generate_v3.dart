import 'dart:io';

void main() {
  final offices = ['HO', 'BD', 'FL', 'CT', 'ST', 'MG', 'CS'];
  final roles = ['psw', 'rn', 'client', 'family_member', 'territory_sales_manager'];
  final basePath = 'lib/modules/offices';

  // 1. Core directories
  Directory('lib/core/layouts').createSync(recursive: true);
  Directory('lib/core/role_templates').createSync(recursive: true);
  Directory('lib/core/forms').createSync(recursive: true);
  Directory('lib/core/components').createSync(recursive: true);

  // 2. Generate Core layout files (Step 1)
  final coreLayoutFiles = [
    'master_layout.dart',
    'master_sidebar_slot.dart',
    'master_topbar_slot.dart',
    'master_content_wrapper.dart',
    'master_mobile_nav.dart',
    'master_language_switcher.dart',
    'master_breadcrumb.dart',
    'master_page_header.dart',
    'master_placeholder_panel.dart'
  ];
  for(final coreFile in coreLayoutFiles) {
     File('lib/core/layouts/$coreFile').writeAsStringSync('// CORE LAYOUT SLOT: $coreFile\n// TODO: Setup Shell UI\n');
  }

  // 3. Generate Form Integration stubs (Step 6)
  final formFiles = [
    'form_registry.dart',
    'form_renderer_adapter.dart',
    'form_permission_mapper.dart',
    'form_translation_mapper.dart',
    'form_schema_loader.dart'
  ];
  for(final formFile in formFiles) {
     File('lib/core/forms/$formFile').writeAsStringSync('// DYNAMIC FORM ADAPTER: $formFile\n// TODO: Integrate dynamic_form_builder logic here\n');
  }

  // 4. Generate Office and Role placeholders (Step 3, 4, 5)
  for (final office in offices) {
    for (final role in roles) {
      final roleDir = Directory('$basePath/$office/$role');
      roleDir.createSync(recursive: true);

      final files = [
        'layout',
        'side_bar',
        'top_bar',
        'dashboard',
        'settings',
        'routes',
        'menu_config',
        'permissions',
        'screen_registry',
        'translation_keys'
      ];

      for (final f in files) {
        final file = File('${roleDir.path}/${role}_$f.dart');
        final placeholderKey = '${office}_${role.toUpperCase()}_${f.toUpperCase()}_PLACEHOLDER';
        
        final content = '''
import 'package:flutter/material.dart';

// PLACEHOLDER_KEY = $placeholderKey
// File: ${role}_$f.dart
// Route: /$office/$role/$f
// Role: $role
// Office: $office
// Status: Placeholder
// TODO: Implement actual UI/Logic, route injection, or specific rendering hooks
// Linked Dynamic Form: If this is an input screen (like notes or vitals), map to dynamic_form_builder registry
// i18n Prefix: $office.$role.$f

class ${capitalize(role)}${capitalizeList(f.split('_'))}Widget extends StatelessWidget {
  const \${capitalize(role)}\${capitalizeList(f.split('_'))}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.all(24),
       child: const Center(
         child: Text(
           'PLACEHOLDER GENERATED:\\n$placeholderKey',
           textAlign: TextAlign.center,
           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
         )
       )
    );
  }
}
''';
        file.writeAsStringSync(content);
      }
    }
  }
  
  // 5. Sidebar/Topbar Shared Engines (Step 7)
  File('lib/core/components/common_sidebar_engine.dart').writeAsStringSync('// COMMON SIDEBAR ENGINE: Used by all role_side_bar configs\n');
  File('lib/core/components/common_topbar_engine.dart').writeAsStringSync('// COMMON TOPBAR ENGINE: Used by all role_top_bar configs\n');

  print('Scaffolded 350+ files dynamically executing the Generation Matrix successfully!');
}

String capitalize(String s) => s.isNotEmpty ? s[0].toUpperCase() + s.substring(1).toLowerCase() : s;
String capitalizeList(List<String> list) => list.map((s) => capitalize(s)).join('');
