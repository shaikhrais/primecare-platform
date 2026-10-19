import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart' show ApiConfig;

/// Downloaded JSON in local app storage. Network refresh is explicit after download.
class LiveScreenTextStore extends ChangeNotifier {
  final http.Client client;
  final String baseUrl;
  final Map<String, Map<String, Map<String, String>>> _catalogs = {};
  final Map<String, int> _versions = {};
  bool _refreshing = false;
  bool _disposed = false;
  Future<void>? _loadingCache;
  final Set<String> _edited = {};
  final List<Map<String,Object?>> _history = [];
  String get _cacheKey => 'primecare.screen-text.v1.${Uri.encodeComponent(baseUrl)}';
  LiveScreenTextStore({http.Client? client, String? baseUrl})
      : client = client ?? http.Client(), baseUrl = baseUrl ?? ApiConfig.baseUrl;
  String? text(String screen, String language, String key) => _catalogs[screen]?[language]?[key];

  bool _accept(Object? value, {String? expected}) {
    if (value is! Map<String, Object?>) throw const FormatException('Invalid text catalog');
    final screen = value['screen'];
    final version = value['version'];
    final raw = value['locales'];
    if (screen is! String || (expected != null && screen != expected) ||
        !RegExp(r'^[a-z][a-z0-9_]{0,79}$').hasMatch(screen) ||
        version is! int || version < 0 || raw is! Map<String, Object?>) throw const FormatException('Invalid text catalog');
    final locales = <String, Map<String, String>>{};
    for (final language in const ['en','fr','es']) {
      final entries = raw[language];
      if (entries is! Map<String, Object?> || entries.isEmpty) throw const FormatException('Invalid text resources');
      final texts = <String,String>{};
      for (final entry in entries.entries) {
        final value = entry.value;
        if (value is! String || value.trim().isEmpty || value.length > 2000) throw const FormatException('Invalid text resource');
        texts[entry.key] = value;
      }
      locales[language] = texts;
    }
    final keys = locales['en']!.keys.toSet();
    if (locales.values.any((entries) => entries.length != keys.length || !keys.containsAll(entries.keys))) throw const FormatException('Text keys differ');
    for (final entries in locales.values) {
      for (final key in keys) {
        if (_parameters(entries[key]!) != _parameters(locales['en']![key]!)) throw const FormatException('Text parameters differ');
      }
    }
    _catalogs[screen] = locales;
    _versions[screen] = version;
    _edited.remove(screen);
    return true;
  }

  Future<void> _loadCache() => _loadingCache ??= _readCache();
  Future<void> _readCache() async {
    bool changed = false;
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = prefs.getString(_cacheKey);
      if (encoded == null || encoded.length > 4000000 || _disposed) return;
      final data = jsonDecode(encoded);
      if (data is! Map<String,Object?> || data['format'] != 1) return;
      final rows = data['catalogs'];
      if (rows is! List<Object?> || rows.length > 500) return;
      for (final row in rows) {
        try { changed = _accept(row) || changed; } catch (_) { /* Skip corrupt downloads. */ }
      }
      final edited = data['edited'];
      if (edited is List<Object?>) _edited.addAll(edited.whereType<String>().where(_catalogs.containsKey));
      final history = data['history'];
      if (history is List<Object?> && history.length <= 50) {
        for (final row in history) {
          if (row is Map<String,Object?> && row['screen'] is String && row['version'] is int &&
              (row['version'] as int) >= 0 && row['created_at'] is String &&
              row['previous_locales'] is Map<String,Object?> && row['locales'] is Map<String,Object?>) _history.add(row);
        }
      }
    } catch (_) { /* Missing/unavailable storage keeps bundled fallback usable. */ }
    if (changed && !_disposed) notifyListeners();
  }

  Future<void> _persist({bool mustPersist = false}) async {
    try {
      String encode() => jsonEncode({'format':1,'edited':_edited.toList(),'history':_history,'catalogs':[
        for (final entry in _catalogs.entries) {'screen':entry.key,'version':_versions[entry.key],'locales':entry.value},
      ]});
      var data = encode();
      while (data.length > 4000000 && _history.isNotEmpty) { _history.removeAt(0); data = encode(); }
      if (data.length > 4000000) throw StateError('Local text storage limit exceeded');
      if (_disposed) return;
      final prefs = await SharedPreferences.getInstance();
      if (!_disposed && !await prefs.setString(_cacheKey, data)) throw StateError('Local text storage unavailable');
    } catch (_) { if (mustPersist) rethrow; }
  }

  Future<void> initialize() async {
    await _loadCache();
    if (_catalogs.isEmpty && !_disposed) await refresh();
  }

  String _parameters(String text) {
    final values = RegExp(r'\{([A-Za-z][A-Za-z0-9_]*)\}').allMatches(text).map((m)=>m.group(1)!).toList()..sort();
    return jsonEncode(values);
  }

  List<Map<String,Object?>> localHistory(String screen) => _history.where((row)=>row['screen']==screen)
      .map((row)=>Map<String,Object?>.from(jsonDecode(jsonEncode(row)) as Map<String,dynamic>)).toList().reversed.toList();

  /// Device-only edits never call the API or publish to other users.
  Future<void> saveLocal(String screen, Map<String,Map<String,String>> locales) async {
    await _loadCache();
    if (_disposed) return;
    final previous = _catalogs[screen];
    if (previous == null || locales['en'] == null || locales['en']!.length != previous['en']!.length ||
        !previous['en']!.keys.every((key)=>locales['en']!.containsKey(key) && _parameters(locales['en']![key]!)==_parameters(previous['en']![key]!))) throw const FormatException('Local text keys or parameters differ');
    final lastVersion = _history.where((row)=>row['screen']==screen).fold<int>(_versions[screen] ?? 0,
      (current,row) {final version=row['version'] as int;return current>version?current:version;});
    final version = lastVersion + 1;
    final oldVersion = _versions[screen]!;
    final oldHistory = List<Map<String,Object?>>.from(_history);
    final wasEdited = _edited.contains(screen);
    _accept({'screen':screen,'version':version,'locales':locales});
    _edited.add(screen);
    _history.add({'screen':screen,'version':version,'actor_id':'device','created_at':DateTime.now().toUtc().toIso8601String(),'previous_locales':previous,'locales':_catalogs[screen]});
    if (_history.length > 50) _history.removeAt(0);
    try { await _persist(mustPersist:true); }
    catch (_) {
      _accept({'screen':screen,'version':oldVersion,'locales':previous});
      _history..clear()..addAll(oldHistory);
      if (wasEdited) _edited.add(screen);
      rethrow;
    }
    if (!_disposed) notifyListeners();
  }

  Future<Object?> _get(String path) async {
    final response = await client.get(Uri.parse('$baseUrl/v1/governance/screen-text$path')).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200 || response.bodyBytes.length > 100000) throw const FormatException('Text resources unavailable');
    return jsonDecode(response.body);
  }

  Future<void> refresh() async {
    await _loadCache();
    if (_refreshing || _disposed) return;
    _refreshing = true;
    bool changed = false;
    try {
      final manifest = await _get('');
      if (manifest is! Map<String, Object?>) throw const FormatException('Invalid text manifest');
      final rows = manifest['screens'];
      if (rows is! List<Object?> || rows.length > 500) throw const FormatException('Invalid text manifest');
      for (final row in rows) {
        if (row is! Map<String, Object?>) throw const FormatException('Invalid text version');
        final screen = row['id'];
        final version = row['version'];
        if (screen is! String || version is! int || version < 0 ||
            !RegExp(r'^[a-z][a-z0-9_]{0,79}$').hasMatch(screen)) throw const FormatException('Invalid screen');
        if (_versions[screen] == version && !_edited.contains(screen)) continue;
        final value = await _get('/$screen');
        if (_disposed) return;
        changed = _accept(value, expected:screen) || changed;
      }
    } catch (_) {
      // Bundled resources keep the application usable when a refresh fails.
    } finally {
      if (changed && !_disposed) await _persist();
      _refreshing = false;
      if (changed && !_disposed) notifyListeners();
    }
  }
  @override void dispose() { _disposed = true; client.close(); super.dispose(); }
}

class LiveScreenTextScope extends StatefulWidget {
  final Widget child;
  final LiveScreenTextStore? store;
  const LiveScreenTextScope({super.key, required this.child, this.store});
  @override State<LiveScreenTextScope> createState() => _LiveScreenTextScopeState();
}
class _LiveScreenTextScopeState extends State<LiveScreenTextScope> {
  late final LiveScreenTextStore store = widget.store ?? LiveScreenTextStore();
  @override void initState() {super.initState();unawaited(store.initialize());}
  @override void dispose() {if(widget.store==null)store.dispose();super.dispose();}
  @override Widget build(BuildContext context) => _ScreenTextInherited(notifier:store,child:widget.child);
}
class _ScreenTextInherited extends InheritedNotifier<LiveScreenTextStore> {
  const _ScreenTextInherited({required super.notifier,required super.child});
}

String liveScreenText(BuildContext context, String screen, String language, String key,
    String fallback, {Map<String,String> args = const {}}) {
  final store=context.dependOnInheritedWidgetOfExactType<_ScreenTextInherited>()?.notifier;
  final value=store?.text(screen,language,key) ?? fallback;
  return value.replaceAllMapped(RegExp(r'\{([A-Za-z][A-Za-z0-9_]*)\}'),(match) {
    final name=match.group(1)!;
    if(!args.containsKey(name))throw ArgumentError('Missing text parameter: $name');
    return args[name]!;
  });
}
