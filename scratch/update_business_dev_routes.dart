import 'dart:io';

void main() {
  final file = File('apps/primecare_business_development/lib/core/routing/business_development_routes.dart');
  var content = file.readAsStringSync();
  
  if (!content.contains('import \'../../features/business_development/presentation/widgets/widgets.dart\';')) {
    content = content.replaceFirst(
      'import \'package:flutter_core/flutter_core.dart\';',
      'import \'package:flutter_core/flutter_core.dart\';\nimport \'../../features/business_development/presentation/widgets/widgets.dart\';\nimport \'package:flutter/material.dart\';'
    );
  }

  // Use regex to add builder
  content = content.replaceAllMapped(
    RegExp(r'PrimeCareScreen\(\s*title:\s*([^,]+),\s*route:\s*BusinessDevelopmentRoutes\.([^,]+),\s*\)'),
    (match) {
      final title = match.group(1)!;
      final routeName = match.group(2)!;
      
      // capitalize first letter
      final className = routeName.substring(0, 1).toUpperCase() + routeName.substring(1) + 'Screen';
      
      return 'PrimeCareScreen(\n      title: $title,\n      route: BusinessDevelopmentRoutes.$routeName,\n      builder: (context) => const $className(),\n    )';
    }
  );

  file.writeAsStringSync(content);
  print('Updated routes.');
}
