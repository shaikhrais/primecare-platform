import 'dart:io';

void main() {
  final dir = Directory(
    'apps/primecare_governance/lib/core/governance/registries',
  );
  final files = dir.listSync().whereType<File>().where(
    (f) => f.path.endsWith('.dart'),
  );

  for (final file in files) {
    var content = file.readAsStringSync();
    bool changed = false;

    // 1. Convert hardcoded titles to LocaleKeys pattern
    final titleRegex = RegExp(r"title: '([^'_\s]+(?:\s+[^'_\s]+)*)'");
    // We only target titles that don't already look like LocaleKeys or camelCase
    content = content.replaceAllMapped(titleRegex, (match) {
      final title = match.group(1)!;
      if (title.contains('LocaleKeys') || title.contains('.'))
        return match.group(0)!;

      final key = title.replaceAll(' ', '');
      changed = true;
      // Determine the domain from the filename
      final domain = file.path
          .split('/')
          .last
          .replaceAll('_registry.dart', '')
          .split('_')
          .map((e) => e[0].toUpperCase() + e.substring(1))
          .join('');
      return "title: 'LocaleKeys.${domain}_$key'";
    });

    // 2. Inject Aura HUD into pendingComponents
    final componentsRegex = RegExp(r"pendingComponents: \[([^\]]*)\]");
    content = content.replaceAllMapped(componentsRegex, (match) {
      final components = match.group(1)!;
      if (components.contains("'Aura HUD'")) return match.group(0)!;
      changed = true;
      if (components.trim().isEmpty) {
        return "pendingComponents: ['Aura HUD']";
      }
      return "pendingComponents: ['Aura HUD', $components]";
    });

    if (changed) {
      file.writeAsStringSync(content);
      print('Sanitized ${file.path}');
    }
  }
}
