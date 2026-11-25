import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_api_errors/primecare_api_errors.dart';
void main() {
  test('maps common failures without echoing raw details', () {
    expect(ErrorMapper.mapApiErrorToUiMessage(null), 'An unknown system error occurred.');
    expect(ErrorMapper.mapApiErrorToUiMessage('TIMEOUT fixture'), contains('check your connection'));
    expect(ErrorMapper.mapApiErrorToUiMessage('401 fixture'), contains('session has expired'));
    expect(ErrorMapper.mapApiErrorToUiMessage('404 fixture'), contains('could not be found'));
    expect(ErrorMapper.mapApiErrorToUiMessage('Synthetic internal detail'), isNot(contains('Synthetic')));
  });
}
