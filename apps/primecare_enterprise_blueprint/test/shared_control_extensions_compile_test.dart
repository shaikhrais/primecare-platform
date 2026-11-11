import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_enterprise_blueprint/main.dart' as migrated0;

void main() {
  test('actual shared control extension consumers compile', () {
    final declarations = <Object>[
      migrated0.MyApp
    ];
    expect(declarations, hasLength(1));
  });
}
