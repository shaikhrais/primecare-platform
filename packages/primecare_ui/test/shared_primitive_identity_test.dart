import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/components/prime_text.dart';
import 'package:primecare_ui/src/components/prime_icon.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' as foundation;

void main() {
  test('existing shared imports export the same foundation class identities', () {
    expect(PrimeText, foundation.PrimeText);
    expect(PrimeIcon, foundation.PrimeIcon);
    expect(const PrimeText('Same implementation'), isA<foundation.PrimeText>());
  });
}
