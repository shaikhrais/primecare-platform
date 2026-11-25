import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_logging/primecare_logging.dart';
void main() {
  test('synthetic diagnostic messages do not throw', () {
    expect(()=>PrimeLogger.info('fixture'), returnsNormally);
    expect(()=>PrimeLogger.warning('fixture', tag:'test'), returnsNormally);
    expect(()=>PrimeLogger.error('fixture', error:StateError('synthetic')), returnsNormally);
    expect(()=>PrimeLogger.clinical('synthetic fixture'), returnsNormally);
  });
}
