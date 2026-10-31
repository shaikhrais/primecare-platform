import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/workspace/workspace_layout.dart';

void main() {
  test('360 web fixtures roundtrip through native with no lost settings', () {
    final fixture = jsonDecode(File('test/workspace/fixtures/web.json').readAsStringSync()) as Map<String, dynamic>;
    final ids = (fixture['panelIds'] as List<dynamic>).cast<String>();
    final profiles = fixture['profiles'] as List<dynamic>;
    expect(profiles.length, 360);
    final exports = <Map<String, Object>>[];
    for (final raw in profiles) {
      final p = WorkspaceLayout.fromJson(raw, ids);
      expect(p.toJson(), raw);
      final exported = WorkspaceLayout.parse(p.exportJson(), ids).toJson();
      expect(exported, raw); exports.add(exported);
    }
    File('test/workspace/fixtures/native.json').writeAsStringSync(jsonEncode(exports));
  });
  test('unknown authority, missing panels, unsafe values and oversized imports fail closed', () {
    final base = WorkspaceLayout.defaults(['note']);
    final invalid = <Map<String, Object?>>[
      {'role': 'admin'}, {'version': 2}, {'navigation': 'url(x)'}, {'maxWidth': double.nan},
      {'navigationWidth': 159}, {'panels': <String, Object>{}}, {'panels': {'denied': base.panels['note']!.toJson()}},
      {'panels': {'note': {...base.panels['note']!.toJson(), 'endpoint': '/admin'}}},
      {'panels': {'note': {...base.panels['note']!.toJson(), 'x': -1}}},
      {'panels': {'note': {...base.panels['note']!.toJson(), 'width': 180.5}}},
    ];
    for (final patch in invalid) {expect(() => base.patch(patch), throwsFormatException);}
    expect(() => WorkspaceLayout.parse(' ' * 32769, ['note']), throwsFormatException);
    expect(() => WorkspaceLayout.parse('é' * 16385, ['note']), throwsFormatException);
    expect(() => WorkspaceLayout.defaults(['constructor']), throwsFormatException);
    expect(() => WorkspaceLayout.defaults(['note', 'note']), throwsFormatException);
    expect(() => base.panel('denied', {'dock': 'left'}), throwsFormatException);
    expect(() => base.panels.clear(), throwsUnsupportedError);
    final source = base.toJson();(source['panels'] as Map<String, Object>).clear();expect(base.panels.length, 1);
  });
}
