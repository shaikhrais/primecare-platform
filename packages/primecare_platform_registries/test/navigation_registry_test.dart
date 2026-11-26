import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_platform_registries/primecare_platform_registries.dart';

void main() {
  test('existing menu names and routes remain case-insensitive', () {
    final menu = NavigationRegistry.getMenuForRole('Administrative Assistant');
    expect(menu, isNotEmpty);
    expect(menu.map((item) => item.route),
        NavigationRegistry.getMenuForRole('administrative assistant').map((item) => item.route));
    expect(menu.first.route, '/common/office-dashboard');
  });
}
