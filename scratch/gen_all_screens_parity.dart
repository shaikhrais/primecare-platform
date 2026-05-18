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
  final groupsDir = Directory('packages/flutter_core/lib/routes/groups');
  final files = groupsDir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  int totalScreens = 0;
  int generatedScreens = 0;

  for (final file in files) {
    final content = file.readAsStringSync();
    final routeRegex = RegExp(r"static const String (\w+)\s*=\s*'(/[^']+)'");
    final routes = routeRegex.allMatches(content);

    for (final match in routes) {
      final routeName = match.group(1)!;
      final routePath = match.group(2)!;
      totalScreens++;

      // Determine app based on routePath
      String appName = 'primecare_ui'; // Fallback
      if (routePath.contains('/corporate')) appName = 'primecare_corporate';
      else if (routePath.contains('/franchise')) appName = 'primecare_franchise';
      else if (routePath.contains('/clinical')) appName = 'primecare_clinic';
      else if (routePath.contains('/support')) appName = 'primecare_support';
      else if (routePath.contains('/marketing')) appName = 'primecare_marketing';
      else if (routePath.contains('/business_development')) appName = 'primecare_business_development';
      else if (routePath.contains('/client')) appName = 'primecare_client';
      else if (routePath.contains('/admin')) appName = 'primecare_governance'; // Map admin to governance

      final parts = routePath.split('/');
      // Usually looks like /offices/clinical/roles/rn/dashboard or /corporate/roles/ceo/dashboard
      String role = 'unknown';
      String screen = 'dashboard';

      if (parts.contains('roles')) {
        int idx = parts.indexOf('roles');
        if (idx + 1 < parts.length) role = parts[idx + 1];
        if (idx + 2 < parts.length) screen = parts[idx + 2];
      }

      final className = toPascalCase(role) + toPascalCase(screen) + 'Screen';
      final fileName = role + '_' + screen.replaceAll('-', '_') + '_screen.dart';

      // Use packages/primecare_ui/lib/src/features/screens as a fallback if the app dir doesn't exist
      String outDirPath = 'apps/$appName/lib/features/generated_screens';
      if (!Directory('apps/$appName').existsSync()) {
        outDirPath = 'packages/primecare_ui/lib/src/features/generated_screens';
      }

      final outDir = Directory(outDirPath);
      if (!outDir.existsSync()) {
        outDir.createSync(recursive: true);
      }

      final filePath = outDir.path + '/' + fileName;
      if (!File(filePath).existsSync()) {
        final code = '''import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class $className extends StatelessWidget {
  const $className({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: '$className',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
''';
        File(filePath).writeAsStringSync(code);
        generatedScreens++;
      }
    }
  }

  print('Total screens analyzed: $totalScreens');
  print('Screens generated: $generatedScreens');
}
