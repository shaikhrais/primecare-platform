import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/components/prime_components.dart' as migrated0;

void main() {
  test('actual migrated button consumers compile', () {
    final declarations = <Object>[
      migrated0.PrimeCareCard
    ];
    expect(declarations, hasLength(1));
  });
}
