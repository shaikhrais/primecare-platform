import 'dart:convert';

/// Data-only v1 contract shared with packages/domain/src/workspace_layout.ts.
/// Panel identities come exclusively from the caller's already-authorized registry.
class WorkspacePanelLayout {
  final String dock;
  final int x, y, width, height;
  const WorkspacePanelLayout(this.dock, this.x, this.y, this.width, this.height);
  Map<String, Object> toJson() => {'dock': dock, 'x': x, 'y': y, 'width': width, 'height': height};
}

class WorkspaceLayout {
  static const docks = ['left', 'right', 'top', 'bottom', 'floating', 'hidden'];
  final String navigation, toolbar, toolbarStyle, footer, container, scroll;
  final int navigationWidth, maxWidth;
  final Map<String, WorkspacePanelLayout> panels;
  WorkspaceLayout._(this.navigation, this.navigationWidth, this.toolbar, this.toolbarStyle,
      this.footer, this.container, this.maxWidth, this.scroll, Map<String, WorkspacePanelLayout> panels)
      : panels = Map.unmodifiable(panels);

  factory WorkspaceLayout.defaults(Iterable<String> panelIds) => WorkspaceLayout.fromJson({
    'version': 1, 'navigation': 'left', 'navigationWidth': 248,
    'toolbar': 'top', 'toolbarStyle': 'sticky', 'footer': 'static',
    'container': 'fullwidth', 'maxWidth': 1280, 'scroll': 'page',
    'panels': {for (final id in panelIds) id: {'dock': 'right', 'x': 32, 'y': 96, 'width': 320, 'height': 360}},
  }, panelIds);

  factory WorkspaceLayout.parse(String text, Iterable<String> panelIds) {
    if (utf8.encode(text).length > 32768) throw const FormatException('Layout file too large');
    return WorkspaceLayout.fromJson(jsonDecode(text), panelIds);
  }

  factory WorkspaceLayout.fromJson(Object? raw, Iterable<String> panelIds) {
    final ids = panelIds.toList(growable: false);
    if (ids.toSet().length != ids.length || ids.any((id) =>
        !RegExp(r'^[a-z][a-z0-9-]{0,63}$').hasMatch(id) || ['constructor', 'prototype'].contains(id))) {
      throw const FormatException('Invalid permitted panel registry');
    }
    final v = _object(raw, ['version', 'navigation', 'navigationWidth', 'toolbar', 'toolbarStyle',
      'footer', 'container', 'maxWidth', 'scroll', 'panels']);
    if (v['version'] != 1) throw const FormatException('Unsupported workspace layout version');
    final source = _object(v['panels'], ids);
    final panels = <String, WorkspacePanelLayout>{};
    for (final id in ids) {
      final p = _object(source[id], ['dock', 'x', 'y', 'width', 'height']);
      panels[id] = WorkspacePanelLayout(_choice(p['dock'], docks), _integer(p['x'], 0, 10000),
        _integer(p['y'], 0, 10000), _integer(p['width'], 180, 1200), _integer(p['height'], 120, 1200));
    }
    return WorkspaceLayout._(_choice(v['navigation'], ['left', 'right', 'top', 'bottom', 'hidden']),
      _integer(v['navigationWidth'], 160, 400), _choice(v['toolbar'], ['top', 'bottom']),
      _choice(v['toolbarStyle'], ['sticky', 'static']), _choice(v['footer'], ['sticky', 'static', 'hidden']),
      _choice(v['container'], ['fullwidth', 'boxed', 'content']), _integer(v['maxWidth'], 960, 1920),
      _choice(v['scroll'], ['page', 'content']), panels);
  }

  Map<String, Object> toJson() => {'version': 1, 'navigation': navigation, 'navigationWidth': navigationWidth,
    'toolbar': toolbar, 'toolbarStyle': toolbarStyle, 'footer': footer, 'container': container,
    'maxWidth': maxWidth, 'scroll': scroll, 'panels': {for (final p in panels.entries) p.key: p.value.toJson()}};
  String exportJson() => jsonEncode(toJson());
  WorkspaceLayout patch(Map<String, Object?> changes) => WorkspaceLayout.fromJson({...toJson(), ...changes}, panels.keys);
  WorkspaceLayout panel(String id, Map<String, Object?> changes) {
    if (!panels.containsKey(id)) throw const FormatException('Panel is not permitted');
    return patch({'panels': {for (final p in panels.entries) p.key: {...p.value.toJson(), if (p.key == id) ...changes}}});
  }
}

Map<String, Object?> _object(Object? value, Iterable<String> keys) {
  final expected = keys.toSet();
  if (value is! Map<Object?, Object?> || value.length != expected.length || !value.keys.every(expected.contains)) {
    throw const FormatException('Unknown or missing layout field');
  }
  return Map<String, Object?>.from(value);
}
String _choice(Object? value, List<String> choices) {
  if (value is! String || !choices.contains(value)) throw const FormatException('Invalid layout choice');
  return value;
}
int _integer(Object? value, int min, int max) {
  if (value is! num || !value.isFinite || value % 1 != 0 || value < min || value > max) {
    throw const FormatException('Invalid layout dimension');
  }
  return value.toInt();
}
