import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';
import 'support/repository_root.dart';

void main() {
  test('blueprint parity observations do not alter source, roles or verification metadata', () async {
    final root = repositoryRoot();
    final source = File('${root.path}/apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
    final before = source.readAsStringSync();
    final metadata = {for (final e in PlatformScreenRegistry.screens.entries) e.key: e.value.toJson()};
    final findings = await CrossSubsystemAuditor(projectRoot: root.path).auditScreenRegistryParity();
    expect(source.readAsStringSync(), before);
    expect({for (final e in PlatformScreenRegistry.screens.entries) e.key: e.value.toJson()}, metadata);
    expect(findings.where((i) => {'missing_registration', 'structural_drift'}
      .contains(i.metadata['type'])).every((i) => !i.autoRemediable), isTrue);
    // Zero missing/drift assertions remain mandatory in the explicit release gate.
  });
}
