import 'admin_reality_filter_catalog.dart';

/// Localize display labels without translating the filter identifiers.
class AdminRealityFilterText {
  static String resolve(String language, String key, {Map<String, String> args = const {}}) {
    final catalog = adminRealityFilterCatalog[language] ?? adminRealityFilterCatalog['en']!;
    final value = catalog[key];
    if (value == null) throw ArgumentError.value(key, 'key', 'Unknown reality filter text');
    return value.replaceAllMapped(RegExp(r'\{([A-Za-z]+)\}'), (match) {
      final name = match.group(1)!;
      if (!args.containsKey(name)) throw ArgumentError('Missing parameter: $name');
      return args[name]!;
    });
  }
}
