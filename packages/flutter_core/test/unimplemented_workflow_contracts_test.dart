import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/generated/unimplemented_workflow_contracts.dart';

void main() {
  test('exact unique review descriptors are never executable readiness', () {
    expect(unimplementedWorkflowContracts, hasLength(1063));
    expect(unimplementedWorkflowContracts.map((item) => item.api).toSet(),
        hasLength(1063));
    final declarationIds = <int>{};
    for (final descriptor in unimplementedWorkflowContracts) {
      expect(descriptor.api, '${descriptor.method} ${descriptor.path}');
      expect(descriptor.noActivation, isTrue);
      expect(descriptor.readiness, isFalse);
      expect(descriptor.missingSlots, hasLength(16));
      expect(descriptor.declarationIds, isNotEmpty);
      for (final id in descriptor.declarationIds) {
        expect(declarationIds.add(id), isTrue);
      }
      expect(() => requireExecutableWorkflow(descriptor.method, descriptor.path),
          throwsUnsupportedError);
    }
  });

  test('unknown workflows fail closed', () {
    expect(() => requireExecutableWorkflow('GET', '/not-a-workflow'),
        throwsUnsupportedError);
  });

  test('known workflow with an incorrect method cannot confer authority', () {
    final descriptor = unimplementedWorkflowContracts.first;
    expect(() => requireExecutableWorkflow('UNSUPPORTED', descriptor.path),
        throwsUnsupportedError);
  });

  test('registry and nested descriptor collections cannot be mutated', () {
    final descriptor = unimplementedWorkflowContracts.first;
    expect(() => unimplementedWorkflowContracts.clear(), throwsUnsupportedError);
    expect(() => descriptor.declarationIds.add(999), throwsUnsupportedError);
    expect(() => descriptor.missingSlots.clear(), throwsUnsupportedError);
    expect(descriptor.readiness, isFalse);
  });
}
