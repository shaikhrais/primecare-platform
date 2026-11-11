import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/services/blueprint_component_evidence.dart';

void main() {
  test('pending-only component declarations cannot clear release parity', () {
    final required = ['header', 'save'];
    final pending = ['save'];
    final missing = BlueprintComponentEvidence.missingImplemented(
      requiredComponents: required, implementedComponents: ['header']);
    expect(missing, ['save']);
    expect(pending.where(missing.contains), ['save']);
    expect(required, ['header', 'save']);
    expect(pending, ['save']);
    expect(() => missing.clear(), throwsUnsupportedError);
  });
  test('all required implementation declarations clear metadata parity only', () {
    expect(BlueprintComponentEvidence.missingImplemented(
      requiredComponents: ['header', 'save'],
      implementedComponents: ['header', 'save', 'extra']), isEmpty);
  });
  test('missing implementation remains blocked with no declarations', () {
    expect(BlueprintComponentEvidence.missingImplemented(
      requiredComponents: ['header'], implementedComponents: []), ['header']);
  });
}
