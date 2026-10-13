import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../network/api_client.dart' show ApiConfig;

/// Shared runtime catalogs. Refresh failures retain bundled or last valid text.
class LiveScreenTextStore extends ChangeNotifier {
  final http.Client client;
  final String baseUrl;
  final Map<String, Map<String, Map<String, String>>> _catalogs = {};
  final Map<String, int> _versions = {};
  bool _refreshing = false;
  bool _disposed = false;
  LiveScreenTextStore({http.Client? client, String? baseUrl})
      : client = client ?? http.Client(), baseUrl = baseUrl ?? ApiConfig.baseUrl;
  String? text(String screen, String language, String key) => _catalogs[screen]?[language]?[key];

  Future<Object?> _get(String path) async {
    final response = await client.get(Uri.parse('$baseUrl/v1/governance/screen-text$path')).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200 || response.bodyBytes.length > 100000) throw const FormatException('Text resources unavailable');
    return jsonDecode(response.body);
  }

  Future<void> refresh() async {
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
        if (_versions[screen] == version) continue;
        final value = await _get('/$screen');
        if (_disposed) return;
        if (value is! Map<String, Object?> || value['screen'] != screen) throw const FormatException('Invalid text catalog');
        final catalogVersion = value['version'];
        final rawLocales = value['locales'];
        if (catalogVersion is! int || catalogVersion < 0 || rawLocales is! Map<String, Object?>) throw const FormatException('Invalid text catalog');
        final locales = <String, Map<String, String>>{};
        for (final language in const ['en','fr','es']) {
          final entries = rawLocales[language];
          if (entries is! Map<String, Object?> || entries.isEmpty) throw const FormatException('Invalid text resources');
          final textEntries = <String,String>{};
          for (final entry in entries.entries) {
            final text = entry.value;
            if (text is! String || text.trim().isEmpty || text.length > 2000) throw const FormatException('Invalid text resource');
            textEntries[entry.key] = text;
          }
          locales[language] = textEntries;
        }
        _catalogs[screen] = locales;
        _versions[screen] = catalogVersion;
        changed = true;
      }
    } catch (_) {
      // Bundled resources keep the application usable when a refresh fails.
    } finally {
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
class _LiveScreenTextScopeState extends State<LiveScreenTextScope> with WidgetsBindingObserver {
  late final LiveScreenTextStore store = widget.store ?? LiveScreenTextStore();
  Timer? timer;
  @override void initState() {super.initState();WidgetsBinding.instance.addObserver(this);start();}
  void start() {timer?.cancel();unawaited(store.refresh());timer=Timer.periodic(const Duration(seconds:30),(_)=>unawaited(store.refresh()));}
  @override void didChangeAppLifecycleState(AppLifecycleState state) {if(state==AppLifecycleState.resumed){start();}else{timer?.cancel();}}
  @override void dispose() {timer?.cancel();WidgetsBinding.instance.removeObserver(this);if(widget.store==null)store.dispose();super.dispose();}
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
