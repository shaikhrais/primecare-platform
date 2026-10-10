import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Snapshots extends BaseSnapshotStore {}
class Intelligence extends BaseIntelligenceService {}
class Service extends BaseResultService {}

void main() {
  test('fetch orchestration returns original data and preserves fallback order', () async {
    final payload = {'value': 7};
    final result = await DataLogisticsHub.fetchAndAssemble('fetch',
      fetchCall: () async => payload, fallbackBuilder: () => throw StateError('unexpected'),
      assembler: (_) => throw StateError('existing assembler stays unused'));
    expect(result, same(payload));
    final order = <String>[];
    final error = StateError('fetch failed');
    final fallback = await DataLogisticsHub.fetchAndAssemble<int>('fallback',
      fetchCall: () async => throw error, assembler: (_) => 0,
      onError: (e, stack) { expect(e, same(error)); order.add('error'); },
      fallbackBuilder: () { order.add('fallback'); return 9; });
    expect(fallback, 9);
    expect(order, ['error', 'fallback']);
    final callbackError = StateError('callback failed');
    await expectLater(DataLogisticsHub.fetchAndAssemble<int>('callback',
      fetchCall: () async => throw error, assembler: (_) => 0,
      onError: (_, stack) => throw callbackError, fallbackBuilder: () => 9),
      throwsA(same(callbackError)));
  });

  test('snapshots preserve input aliasing, shallow retrieval copies and flush', () async {
    final store = Snapshots();
    expect(await store.getSnapshot('missing'), isNull);
    final nested = {'value': 1};
    final payload = <String, dynamic>{'nested': nested};
    await store.saveSnapshot('key', payload);
    payload['added'] = true;
    final copy = (await store.getSnapshot('key'))!;
    expect(copy, isNot(same(payload)));
    expect(copy['added'], isTrue);
    expect(copy['nested'], same(nested));
    copy['local'] = 1;
    expect((await store.getSnapshot('key'))!.containsKey('local'), isFalse);
    store.flush();
    expect(await store.getSnapshot('key'), isNull);
  });

  test('shared intelligence preserves revenue and role rules', () {
    final metrics = DashboardMetrics(kpis: {}, charts: [
      const AnalyticsChart(id: 'revenue', title: 'Revenue', type: ChartType.line,
        dataPoints: [DataPoint(label: 'old', value: 10), DataPoint(label: 'new', value: 20)])
    ], recentActivity: [], insights: []);
    final insights = Intelligence().synthesizeInsights('admin', metrics);
    expect(insights.map((i) => i.id), ['revenue_growth', 'capacity_alert']);
    expect(insights.first.summary, contains('100.0%'));
    expect(Intelligence().synthesizeInsights('client', DashboardMetrics.empty()), isEmpty);
  });

  test('shared command service preserves query precedence and unknown fallback', () {
    final commands = AuraCommandService();
    expect(commands.processQuery('schedule finance').getOrThrow().actions.single.type,
      AuraActionType.reassign);
    expect(commands.processQuery('mute revenue').getOrThrow().actions.single.type,
      AuraActionType.snooze);
    expect(commands.processQuery('unrecognized').getOrThrow().confidence, 0);
    expect(commands.getSuggestions(context: 'cfo').first, 'Analyze revenue leakage');
    expect(Service().guardSync(() => 4).getOrThrow(), 4);
    final error = StateError('failed');
    expect(Service().guardSync<int>(() => throw error).getOrThrow, throwsA(same(error)));
  });
}
