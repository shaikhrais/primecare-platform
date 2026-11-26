import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_portal_state/primecare_portal_state.dart';

void main() {
  test('sidebar override and responsive layout use the same provider state', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(sidebarModeProvider), SidebarMode.extended);
    container.read(sidebarOverrideProvider.notifier).setMode(SidebarMode.hidden);
    expect(container.read(sidebarModeProvider), SidebarMode.hidden);
    expect(container.read(layoutProvider).sidebarWidth, 0);
  });
}
