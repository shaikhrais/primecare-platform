import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_url_strategy/primecare_url_strategy.dart';

void main() {
  test('native URL strategy is a safe no-op', () {
    expect(configureUrlStrategy, returnsNormally);
  });
}
