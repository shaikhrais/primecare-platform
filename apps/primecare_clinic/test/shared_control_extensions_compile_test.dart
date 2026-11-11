import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_clinic/features/physician/screens/physician_dashboard_screen.dart' as migrated0;

void main() {
  test('actual shared control extension consumers compile', () {
    final declarations = <Object>[
      migrated0.PhysicianDashboardScreen
    ];
    expect(declarations, hasLength(1));
  });
}
