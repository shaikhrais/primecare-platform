import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_preferences/primecare_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('host override preserves zoom persistence, clamping and reset', () async {
    SharedPreferences.setMockInitialValues({'pref_content_zoom': 1.2});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [sharedPreferencesProvider.overrideWithValue(prefs)]);
    addTearDown(container.dispose);
    expect(container.read(contentZoomProvider), 1.2);
    final zoom = container.read(contentZoomProvider.notifier);
    for (int i = 0; i < 10; i++) { await zoom.zoomIn(); }
    expect(container.read(contentZoomProvider), 1.8);
    expect(prefs.getDouble('pref_content_zoom'), 1.8);
    for (int i = 0; i < 20; i++) { await zoom.zoomOut(); }
    expect(container.read(contentZoomProvider), 0.7);
    expect(prefs.getDouble('pref_content_zoom'), 0.7);
    await zoom.resetZoom();
    expect(container.read(contentZoomProvider), 1.0);
    expect(prefs.containsKey('pref_content_zoom'), isFalse);
  });
  test('no host persistence defaults to normal zoom', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(contentZoomProvider), 1.0);
  });
}
