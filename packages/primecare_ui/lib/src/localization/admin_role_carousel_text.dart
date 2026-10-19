import 'admin_role_carousel_catalog.dart';

/// Shared, synchronous UI translations generated from the en/es/fr catalogs.
/// Data such as user names, paths, and backend audit descriptions stays intact.
class AdminRoleCarouselText {
  static final _parameter = RegExp(r'\{([a-zA-Z][a-zA-Z0-9_]*)\}');

  static bool contains(String key) => adminRoleCarouselCatalog['en']!.containsKey(key);

  static String resolve(String language, String key, {Map<String, String> args = const {}}) {
    final catalog = adminRoleCarouselCatalog[language] ?? adminRoleCarouselCatalog['en']!;
    final value = catalog[key];
    if (value == null) throw ArgumentError.value(key, 'key', 'Unknown UI translation');
    // Replace each original placeholder once; parameter values are never reinterpreted.
    return value.replaceAllMapped(_parameter, (match) {
      final name = match.group(1)!;
      if (!args.containsKey(name)) throw ArgumentError('Missing translation parameter: $name');
      return args[name]!;
    });
  }
}
