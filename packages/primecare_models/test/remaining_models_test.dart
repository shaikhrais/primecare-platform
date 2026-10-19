import 'package:test/test.dart';
import 'package:primecare_models/primecare_models.dart';

class Placeholder extends BaseEmptyModel {
  const Placeholder();
}
void main() {
  test('placeholder serialization returns a fresh empty map', () {
    const p = Placeholder();
    final first = p.toJson();
    first['unexpected'] = 'value';
    expect(p.toJson(), isEmpty);
  });
  test('dashboard uses the single shared impact enum and unchanged JSON', () {
    final insight = IntelligenceInsight.fromJson({
      'id': 'insight-1', 'title': 'Trend', 'summary': 'Summary', 'impact': 'alert',
    });
    expect(insight.impact, InsightImpact.alert);
    expect(insight.toJson()['impact'], 'alert');
    expect(InsightImpact.values.map((v) => v.name),
      ['positive', 'info', 'caution', 'alert', 'critical']);
  });
  test('shared custom view model retains inherited serialization behavior', () {
    final model = MainProjectSelectionViewModel(title: 'Selection');
    expect(model.isOfflineFallback, isFalse);
    expect(model.toJson(), {
      'title': 'Selection', 'metadata': <String, dynamic>{},
      'isOfflineFallback': false,
    });
  });
}
