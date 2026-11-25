import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_data_logistics/primecare_data_logistics.dart';
void main() {
  test('fetch success and fixture fallback retain behavior', () async {
    expect(await DataLogisticsHub.fetchAndAssemble('fixture', fetchCall: () async => 5, fallbackBuilder: () => 0, assembler: (_) => 5), 5);
    expect(await DataLogisticsHub.fetchAndAssemble('fixture', fetchCall: () async => throw StateError('fixture'), fallbackBuilder: () => 0, assembler: (_) => 5), 0);
  });
}
