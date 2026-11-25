import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_local_cache/primecare_local_cache.dart';
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('synthetic response round trips and cache clears', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final cache = LocalCacheService(prefs);
    await cache.cacheResponse('/fixture', {'value': 3});
    expect(cache.getCachedResponse('/fixture'), {'value': 3});
    await cache.clearCache();
    expect(cache.getCachedResponse('/fixture'), isNull);
  });
}
