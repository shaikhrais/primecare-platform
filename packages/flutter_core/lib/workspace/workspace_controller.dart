import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'workspace_layout.dart';

abstract interface class WorkspacePreferences {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
}

/// Immutable actor identity prevents old asynchronous work from crossing accounts.
class WorkspaceScope {
  final String tenant, user, role, dataset;
  WorkspaceScope({required this.tenant, required this.user, required this.role, this.dataset = 'live'}) {
    if ([tenant, user, role, dataset].any((v) => v.trim().isEmpty)) throw ArgumentError('Authenticated workspace scope required');
  }
  String get storageKey => 'primecare-workspace:v1:${Uri.encodeComponent(jsonEncode([tenant, user, role, dataset]))}';
}

class WorkspaceController extends ChangeNotifier {
  final WorkspaceScope scope;
  final WorkspacePreferences? preferences;
  final WorkspaceLayout defaults;
  late WorkspaceLayout _current;
  final List<WorkspaceLayout> _undo = [], _redo = [];
  WorkspaceLayout? _gesture;
  bool _disposed = false;
  int _revision = 0;
  WorkspaceController({required this.scope, required Iterable<String> panelIds, this.preferences,
      WorkspaceLayout? initial, String? legacyLayoutStyle})
      : defaults = _initial(panelIds, initial, legacyLayoutStyle) { _current = defaults; }
  WorkspaceLayout get current => _current;
  bool get canUndo => _undo.isNotEmpty;
  bool get canRedo => _redo.isNotEmpty;
  bool get inGesture => _gesture != null;
  void _alive() {if (_disposed) throw StateError('Workspace disposed');}
  void _idle() {_alive(); if (inGesture) throw StateError('Finish or cancel the layout gesture first');}
  void _emit() {_revision++; notifyListeners();}
  void _remember(WorkspaceLayout before) {_undo.add(before); if (_undo.length > 30) _undo.removeAt(0); _redo.clear();}
  void change(WorkspaceLayout next) {
    _idle(); final checked = WorkspaceLayout.fromJson(next.toJson(), defaults.panels.keys);
    if (checked.exportJson() == _current.exportJson()) return;
    _remember(_current); _current = checked; _emit();
  }
  void patch(Map<String, Object?> changes) => change(current.patch(changes));
  void dock(String id, String dock) => change(current.panel(id, {'dock': dock}));
  void undo() {_alive(); cancelGesture(); if (_undo.isNotEmpty) {_redo.add(_current); _current = _undo.removeLast(); _emit();}}
  void redo() {_alive(); cancelGesture(); if (_redo.isNotEmpty) {_undo.add(_current); _current = _redo.removeLast(); _emit();}}
  void reset() => change(defaults);
  String exportJson() { _idle(); return current.exportJson(); }
  void importJson(String text) => change(WorkspaceLayout.parse(text, defaults.panels.keys));
  Future<bool> load() async {
    _idle(); final revision = _revision;
    final source = await preferences?.read(scope.storageKey);
    if (_disposed || revision != _revision || inGesture) return false;
    if (source == null) return false;
    WorkspaceLayout next;
    try {next = WorkspaceLayout.parse(source, defaults.panels.keys);} on FormatException {return false;}
    _current = next; _undo.clear(); _redo.clear(); _emit(); return true;
  }
  Future<void> save() async {
    _idle(); if (preferences == null) throw StateError('Workspace storage unavailable');
    final source = exportJson(); await preferences!.write(scope.storageKey, source); _alive();
  }
  void beginGesture() {_idle(); _gesture = current;}
  void preview(WorkspaceLayout next) {
    _alive(); if (!inGesture) throw StateError('No active layout gesture');
    _current = WorkspaceLayout.fromJson(next.toJson(), defaults.panels.keys); _emit();
  }
  void commitGesture() {
    _alive(); final before = _gesture; _gesture = null;
    if (before != null && before.exportJson() != current.exportJson()) {_remember(before); _emit();}
  }
  void cancelGesture() {
    _alive(); final before = _gesture; _gesture = null;
    if (before != null) {_current = before; _emit();}
  }
  @override void dispose() {if (_disposed) return; _disposed = true; _gesture = null; super.dispose();}
}

WorkspaceLayout _initial(Iterable<String> ids, WorkspaceLayout? initial, String? legacy) {
  if (initial != null) return WorkspaceLayout.fromJson(initial.toJson(), ids);
  final defaults = WorkspaceLayout.defaults(ids);
  // Copy only presentation from the current actor's already-loaded native settings.
  // Never read or migrate the historical role-only pref_layout_* namespace.
  return switch (legacy) {
    null || 'verticalLeft' || 'collapsed' => defaults,
    'verticalRight' => defaults.patch({'navigation': 'right'}),
    'horizontal' => defaults.patch({'navigation': 'top'}),
    _ => throw const FormatException('Unknown legacy layout style'),
  };
}
