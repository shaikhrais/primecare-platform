import 'dart:convert';
import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Store implements ResponseCacheStorage {
  final values = <String, String>{};
  @override
  String? getString(String key) => values[key];
  @override
  Set<String> getKeys() => values.keys.toSet();
  @override
  Future<bool> setString(String key, String value) async {
    values[key] = value;
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    values.remove(key);
    return true;
  }
}

class Cache extends BaseResponseCache {
  Cache(super.storage);
}

String token(Object payload) =>
    'h.${base64Url.encode(utf8.encode(jsonEncode(payload)))}.s';
void main() {
  test('cache round trip, invalid JSON and selective clearing', () async {
    final store = Store()..values['other'] = 'keep';
    final cache = Cache(store);
    await cache.cacheResponse('/a', {
      'nested': [1, true],
    });
    expect(cache.getCachedResponse('/a'), {
      'nested': [1, true],
    });
    store.values['api_cache_/broken'] = '[]';
    expect(cache.getCachedResponse('/broken'), isNull);
    await cache.clearCache();
    expect(store.values, {'other': 'keep'});
  });
  test('absent storage remains a no-op', () async {
    final cache = Cache(null);
    await cache.cacheResponse('/a', {'value': Object()});
    expect(cache.getCachedResponse('/a'), isNull);
    await cache.clearCache();
  });
  test('JWT claim priority and existing expiration behavior', () {
    final value = token({
      'role': 'admin',
      'activeRole': 'staff',
      'tenantId': 9,
    });
    expect(JwtDecoder.extractRole(value), 'admin');
    expect(JwtDecoder.extractTenantId(value), '9');
    expect(JwtDecoder.isTokenExpired(token({'exp': '1'})), isTrue);
    expect(JwtDecoder.isTokenExpired(token({'exp': 4102444800})), isFalse);
    expect(JwtDecoder.isTokenExpired('bad'), isFalse);
    expect(JwtDecoder.parseJwt(token([])), isEmpty);
    expect(JwtDecoder.extractRole('h.!.s'), isNull);
  });
  test('error mapping precedence', () {
    expect(ErrorMapper.mapApiErrorToUiMessage(null), contains('unknown'));
    expect(
      ErrorMapper.mapApiErrorToUiMessage('401 timeout'),
      contains('connection'),
    );
    expect(
      ErrorMapper.mapApiErrorToUiMessage('UNAUTHORIZED 404'),
      contains('session'),
    );
    expect(ErrorMapper.mapApiErrorToUiMessage(404), contains('record'));
  });
}
