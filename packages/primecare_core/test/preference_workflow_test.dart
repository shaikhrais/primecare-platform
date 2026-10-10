import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Store implements PreferenceStore {
  final values = <String, Object>{};
  final removed = <String>[];
  bool failWrites = false;
  @override
  List<String>? getStringList(String key) =>
      (values[key] as List<String>?)?.toList();
  @override
  bool? getBool(String key) => values[key] as bool?;
  @override
  String? getString(String key) => values[key] as String?;
  Future<bool> write(String key, Object value) async {
    if (failWrites) throw StateError('write failed');
    values[key] = value;
    return true;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) =>
      write(key, value);
  @override
  Future<bool> setBool(String key, bool value) => write(key, value);
  @override
  Future<bool> setString(String key, String value) => write(key, value);
  @override
  Future<bool> remove(String key) async {
    removed.add(key);
    values.remove(key);
    return true;
  }
}

class Telemetry extends BaseExecutionGateService {
  final messages = <String>[];
  @override
  void log(String message) => messages.add(message);
}

class Workflow extends BasePreferenceWorkflow<Telemetry> {
  Workflow(super.preferenceStore, super.telemetry);
}

void main() {
  test(
    'favorites preserve role keys, toggle actions and inherited telemetry',
    () async {
      final store = Store();
      final telemetry = Telemetry();
      final workflow = Workflow(store, telemetry);
      expect(workflow, isA<BaseTelemetryService<Telemetry>>());
      expect(workflow.telemetry, same(telemetry));
      expect(workflow.getFavorites('rmt'), isEmpty);
      await workflow.toggleFavorite('rmt', 'one');
      expect(workflow.getFavorites('rmt'), ['one']);
      expect(workflow.getFavorites('psw'), isEmpty);
      expect(store.values.keys, ['pref_favorites_rmt']);
      expect(telemetry.messages.single, contains('action: added'));
      await workflow.toggleFavorite('rmt', 'one');
      expect(workflow.getFavorites('rmt'), isEmpty);
      expect(telemetry.messages.last, contains('action: removed'));
    },
  );
  test('pins and layouts retain persistence and clear semantics', () async {
    final store = Store();
    final workflow = Workflow(store, Telemetry());
    expect(workflow.isPinned('rmt', 'one'), isFalse);
    expect(workflow.getLayoutConfig('rmt').getOrThrow(), isNull);
    await workflow.setPinned('rmt', 'one', true);
    await workflow.saveLayoutConfig('rmt', {
      'columns': 2,
      'items': ['one'],
    });
    await workflow.toggleFavorite('rmt', 'one');
    expect(workflow.getLayoutConfig('rmt').getOrThrow(), {
      'columns': 2,
      'items': ['one'],
    });
    await workflow.clearRolePreferences('rmt');
    expect(store.removed, ['pref_favorites_rmt', 'pref_layout_rmt']);
    expect(workflow.getFavorites('rmt'), isEmpty);
    expect(workflow.getLayoutConfig('rmt').getOrThrow(), isNull);
    expect(workflow.isPinned('rmt', 'one'), isTrue);
  });
  test('corrupt layout retains null recovery and stack diagnostic', () {
    final store = Store()..values['pref_layout_rmt'] = '[]';
    final telemetry = Telemetry();
    final result = Workflow(store, telemetry).getLayoutConfig('rmt');
    expect(result, isA<Success<Map<String, dynamic>?>>());
    expect(result.getOrThrow(), isNull);
    expect(telemetry.messages.first, contains('Memory Corruption'));
    expect(telemetry.messages, hasLength(2));
  });
  test('failed writes are guarded with failure telemetry', () async {
    final store = Store()..failWrites = true;
    final telemetry = Telemetry();
    final workflow = Workflow(store, telemetry);
    await workflow.toggleFavorite('rmt', 'one');
    await workflow.setPinned('rmt', 'one', true);
    await workflow.saveLayoutConfig('rmt', {'columns': 2});
    expect(store.values, isEmpty);
    expect(
      telemetry.messages.where((message) => message.startsWith('FAIL_GATE')),
      hasLength(3),
    );
  });
  test('execution gate retains silence, alias and stack-log order', () {
    final telemetry = Telemetry();
    telemetry.passGate(ExecutionGateCategory.storage, 'silent', silent: true);
    expect(telemetry.messages, isEmpty);
    telemetry.track(
      ExecutionGateCategory.storage,
      'tracked',
      metadata: {'key': 1},
    );
    expect(
      telemetry.messages.single,
      'PASS_GATE [ExecutionGateCategory.storage]: tracked {key: 1}',
    );
    telemetry.failGate(
      ExecutionGateCategory.storage,
      'failed',
      error: 'error',
      stackTrace: StackTrace.fromString('test-stack'),
    );
    expect(
      telemetry.messages[1],
      'FAIL_GATE [ExecutionGateCategory.storage]: failed error ',
    );
    expect(telemetry.messages.last, 'test-stack');
  });
}
