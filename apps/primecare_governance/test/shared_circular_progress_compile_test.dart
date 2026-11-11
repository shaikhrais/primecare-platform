import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/widgets/governance_dashboard.dart' as view0;
import 'package:primecare_governance/governance/widgets/governance_master_score.dart' as view1;

void main() {
  test('actual shared progress consumers compile', () {
    final types=<Type>[
      view0.GovernanceDashboard,
      view1.GovernanceMasterScore
    ];
    expect(types,hasLength(2));
  });
}
