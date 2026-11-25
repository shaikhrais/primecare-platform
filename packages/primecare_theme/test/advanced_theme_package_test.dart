import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_theme/primecare_theme.dart';

void main() {
  test('named theme controller persists and isolates presentation profiles', () async {
    final storage = <String, String>{};
    AdvancedThemeController controller(String scope) => AdvancedThemeController(
      scope: scope,
      read: (key) async => storage[key],
      write: (key, value) async { storage[key] = value; },
    );
    final first = controller('one');
    await first.initialize();
    await first.apply(AdvancedTheme.defaults());
    final second = controller('two');
    await second.initialize();
    expect(second.active, isNull);
    expect(first.active, isNotNull);
    first.dispose();
    second.dispose();
  });
  test('missing section inherits main theme', () {
    final theme = ThemeData();
    expect(portalSectionTheme(theme, 'toolbar'), same(theme));
  });
}
