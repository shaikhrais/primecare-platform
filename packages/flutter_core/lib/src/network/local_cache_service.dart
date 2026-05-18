import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/persistence_providers.dart';

final localCacheServiceProvider = Provider<LocalCacheService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalCacheService(prefs);
});

class LocalCacheService {
  final SharedPreferences? _prefs;
  
  LocalCacheService(this._prefs);

  static const String _cachePrefix = 'api_cache_';

  String _getKey(String path) => '$_cachePrefix$path';

  Future<void> cacheResponse(String path, Map<String, dynamic> data) async {
    if (_prefs == null) return;
    final key = _getKey(path);
    final jsonString = jsonEncode(data);
    await _prefs.setString(key, jsonString);
  }

  Map<String, dynamic>? getCachedResponse(String path) {
    if (_prefs == null) return null;
    final key = _getKey(path);
    final jsonString = _prefs.getString(key);
    
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        // If decoding fails, return null
        return null;
      }
    }
    return null;
  }
  
  Future<void> clearCache() async {
    if (_prefs == null) return;
    final keys = _prefs.getKeys().where((k) => k.startsWith(_cachePrefix));
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }
}
