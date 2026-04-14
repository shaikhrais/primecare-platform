import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/flutter_core.dart';

void main() {
  group('DataLogisticsHub - Fetch-or-Fallback Logic', () {
    test('fetchAndAssemble should return data on successful fetch', () async {
      final result = await DataLogisticsHub.fetchAndAssemble<String>(
        fetchCall: () async => 'Success',
        fallbackBuilder: () => 'Fallback',
      );

      expect(result, equals('Success'));
    });

    test('fetchAndAssemble should return fallback on fetch failure', () async {
      final result = await DataLogisticsHub.fetchAndAssemble<String>(
        fetchCall: () async => throw Exception('Fetch failed'),
        fallbackBuilder: () => 'Fallback',
      );

      expect(result, equals('Fallback'));
    });

    test('fetchAndAssemble should call onError on fetch failure', () async {
      bool errorCalled = false;
      await DataLogisticsHub.fetchAndAssemble<String>(
        fetchCall: () async => throw Exception('Fetch failed'),
        fallbackBuilder: () => 'Fallback',
        onError: (e, st) {
          errorCalled = true;
        },
      );

      expect(errorCalled, isTrue);
    });

    test('getClinicIntelligenceMetrics should return a valid offline fallback model', () {
      final model = DataLogisticsHub.getClinicIntelligenceMetrics();

      expect(model.isOfflineFallback, isTrue);
      expect(model.blueprints, isNotEmpty);
      expect(model.blueprints.any((b) => b is StatGridBlueprint), isTrue);
    });
  });
}
