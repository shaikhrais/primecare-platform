import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_screen_registry_data/primecare_screen_registry_data.dart';

void main() {
  test('local snapshot preserves canonical screen identifiers', () {
    final screens = DbScreenStatusRegistry.screens;
    expect(screens, isNotEmpty);
    for (final entry in screens.entries) {
      expect(entry.value['screenCode'], entry.key);
    }
  });
}
