import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/workspace.dart';

class MemoryPreferences implements WorkspacePreferences {
  final values = <String, String>{};
  bool fail = false;
  Completer<String?>? pending;
  @override Future<String?> read(String key) async {if (pending != null) return await pending!.future;return values[key];}
  @override Future<void> write(String key, String value) async {
    if (fail) throw StateError('storage failure');values[key] = value;
  }
}
WorkspaceScope scope([String actor = 'actor', String tenant = 'tenant', String role = 'staff']) =>
  WorkspaceScope(tenant: tenant, user: actor, role: role);
WorkspaceController controller({WorkspaceScope? identity, WorkspacePreferences? preferences}) =>
  WorkspaceController(scope: identity ?? scope(), panelIds: ['note'], preferences: preferences);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('gesture is one undo entry; cancellation and invalid import preserve history', () {
    final c = controller();addTearDown(c.dispose);final initial = c.exportJson();
    c.beginGesture();for (var i = 0; i < 20; i++) {c.preview(c.current.panel('note', {'dock': 'floating', 'x': i}));}
    expect(c.canUndo, false);expect(c.exportJson, throwsStateError);c.commitGesture();
    c.undo();expect(c.exportJson(), initial);c.redo();expect(c.current.panels['note']!.x, 19);
    final before = c.exportJson();c.beginGesture();c.preview(c.current.panel('note', {'x': 800}));c.cancelGesture();expect(c.exportJson(), before);
    expect(() => c.importJson('{"role":"admin"}'), throwsFormatException);expect(c.exportJson(), before);
    c.reset();expect(c.exportJson(), initial);
  });
  test('bounded history and disposed controller', () {
    final c = controller();for (var i = 0; i < 50; i++) {c.patch({'navigationWidth': 200 + i});}
    var undos = 0;while (c.canUndo) {c.undo();undos++;}expect(undos, 30);
    c.dispose();expect(() => c.patch({'navigation': 'right'}), throwsStateError);
  });
  test('device persistence isolates tenant, actor, role and dataset and preserves legacy settings', () async {
    SharedPreferences.setMockInitialValues({'pref_layout_staff': '{"unsafe":"historical role-only"}', 'theme_center_settings_v1:old': 'unchanged'});
    final prefs = await SharedPreferences.getInstance(), store = SharedWorkspacePreferences(await SharedPreferences.getInstance());
    final c = controller(preferences: store);addTearDown(c.dispose);c.dock('note', 'floating');await c.save();
    final reload = controller(preferences: store);addTearDown(reload.dispose);expect(await reload.load(), true);expect(reload.exportJson(), c.exportJson());
    for (final identity in [scope('other'), scope('actor', 'other'), scope('actor', 'tenant', 'admin'), WorkspaceScope(tenant: 'tenant', user: 'actor', role: 'staff', dataset: 'demo')]) {
      final other = controller(identity: identity, preferences: store);expect(await other.load(), false);expect(other.current.panels['note']!.dock, 'right');other.dispose();
    }
    expect(prefs.getString('pref_layout_staff'), '{"unsafe":"historical role-only"}');
    expect(prefs.getString('theme_center_settings_v1:old'), 'unchanged');
    expect(() => WorkspaceScope(tenant: '', user: 'actor', role: 'staff'), throwsArgumentError);
    expect(scope('a:b', 'c').storageKey, isNot(scope('b', 'c:a').storageKey));
  });
  test('late loads cannot overwrite edits or publish after account disposal; save failure is visible', () async {
    final store = MemoryPreferences()..pending = Completer<String?>();final c = controller(preferences: store);
    final pending = c.load();c.patch({'navigation': 'right'});store.pending!.complete(WorkspaceLayout.defaults(['note']).exportJson());
    expect(await pending, false);expect(c.current.navigation, 'right');
    store.fail = true;await expectLater(c.save(), throwsStateError);expect(c.current.navigation, 'right');
    store.pending = Completer<String?>();final late = c.load();c.dispose();store.pending!.complete(WorkspaceLayout.defaults(['note']).exportJson());expect(await late, false);
  });
  test('trusted legacy presentation mapping never reads the role-only namespace', () async {
    for (final pair in [('verticalLeft', 'left'), ('verticalRight', 'right'), ('horizontal', 'top'), ('collapsed', 'left')]) {
      final c = WorkspaceController(scope: scope(), panelIds: ['note'], legacyLayoutStyle: pair.$1);
      expect(c.current.navigation, pair.$2);c.dispose();
    }
    final store = MemoryPreferences(), c = controller(preferences: MemoryPreferences());c.dispose();
    final fresh = controller(preferences: store);store.values[fresh.scope.storageKey] = '{"role":"admin"}';expect(await fresh.load(), false);fresh.dispose();
  });
}
