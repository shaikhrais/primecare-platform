import 'dart:io';

String toPascalCase(String text) {
  return text.split('_').map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '').join('');
}

void main() {
  final dir = Directory('lib/modules/offices');
  final entities = dir.listSync(recursive: true);

  int modifiedCount = 0;

  for (final entity in entities) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final fileName = entity.uri.pathSegments.last;
      String content = entity.readAsStringSync();
      bool changed = false;

      // Fix the literal class names left by the broken generator
      if (content.contains('\${roleClassNamePrefix}')) {
        final baseName = fileName.replaceAll('.dart', '');
        final properClassName = toPascalCase(baseName) + 'Widget';
        
        content = content.replaceAll('\${roleClassNamePrefix}\${classNameSuffix}Widget', properClassName);
        content = content.replaceAll('\${roleClassNamePrefix}DashboardWidget', properClassName);
        
        // Also fix any other template literal variations
        content = content.replaceAll('\${officeTitle}', 'Office');
        content = content.replaceAll('\${roleTitle}', toPascalCase(baseName.replaceAll('_dashboard', '')));
        changed = true;
      }

      // Apply the dashboard hydrate fix properly!
      if (fileName.endsWith('_dashboard.dart')) {
        final roleKey = fileName.replaceAll('_dashboard.dart', '');
        
        if (!content.contains('role_data_builder.dart')) {
            content = content.replaceFirst(
               "import 'package:primecare_ui/primecare_ui.dart';",
               "import 'package:primecare_ui/primecare_ui.dart';\nimport '../../../../core/components/role_data_builder.dart';"
            );
            changed = true;
        }

        if (!content.contains('RoleDataBuilder(')) {
            final bannerRegex = RegExp(r'const\s+UrgentAlertBanner\s*\([^)]+\),', multiLine: true);
            if (bannerRegex.hasMatch(content)) {
                content = content.replaceFirst(bannerRegex, '''            RoleDataBuilder(
              roleId: '$roleKey',
              builder: (context, data) {
                return DashboardKpiGrid(kpis: data.kpis, title: '\${data.greetingTitle} | Metrics');
              },
            ),''');
                changed = true;
            }
        }
      }

      if (changed) {
        entity.writeAsStringSync(content);
        modifiedCount++;
      }
    }
  }
  print('Fixed: \$modifiedCount files.');
}
