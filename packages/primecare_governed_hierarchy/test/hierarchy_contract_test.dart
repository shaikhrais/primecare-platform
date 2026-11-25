import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governed_hierarchy/primecare_governed_hierarchy.dart';

class ExamplePolicy extends Policy {
  const ExamplePolicy(): super(id: 'fixture', description: 'Fixture policy');
  @override
  bool validate(dynamic target) => target == 'fixture';
}
void main() {
  test('policy metadata remains intact', () {
    const policy = ExamplePolicy();
    expect(policy.id, 'fixture');
    expect(policy.description, 'Fixture policy');
  });
}
