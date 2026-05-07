import 'dart:io';

void main() {
  final dir = Directory(
    'packages/factory_system/primecare_ui/lib/src/screens/stitch_generated',
  );
  if (!dir.existsSync()) {
    print('Directory not found');
    return;
  }

  final files = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  for (var file in files) {
    final name = file.path
        .split(Platform.pathSeparator)
        .last
        .replaceAll('.dart', '');
    // Convert snake_case to CamelCase
    final className = name
        .split('_')
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join('');
    final location = file.path.replaceAll(r'\', '/');

    final content =
        '''
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class $className extends StatelessWidget {
  const $className({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = PrimeTheme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(theme.spacing.md),
          decoration: BoxDecoration(
            color: theme.colors.surfaceContainer,
            borderRadius: BorderRadius.circular(theme.radiusLg),
            border: Border.all(color: theme.colors.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.monitor, size: 48, color: theme.colors.primary),
              SizedBox(height: theme.spacing.md),
              Text(
                'Screen: $className',
                style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
              ),
              SizedBox(height: theme.spacing.sm),
              Text(
                'Location: $location',
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: theme.spacing.lg),
              Container(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.sm),
                decoration: BoxDecoration(
                  color: theme.colors.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                ),
                child: Text(
                  'Metadata placeholder only',
                  style: theme.typography.labelBold.copyWith(color: theme.colors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';
    file.writeAsStringSync(content);
    print('Updated \${file.path}');
  }
}
