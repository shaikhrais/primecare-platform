import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';
import 'package:primecare_governance/governance/services/governance_remediation_engine.dart';
import 'package:primecare_governance/governance/services/registry_integrity_service.dart';

void main() {
  late Directory root;
  late Map<String, ScreenMetadata> screens;
  late CrossSubsystemAuditor auditor;
  void write(String path, String contents) {
    final file = File('${root.path}/$path');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(contents);
  }
  Map<String, String> snapshot() => {
    for (final file in root.listSync(recursive: true).whereType<File>())
      file.path: file.readAsStringSync(),
  };

  setUp(() async {
    root = await Directory.systemTemp.createTemp('remediation-evidence-');
    auditor = CrossSubsystemAuditor(projectRoot: root.path);
    write('packages/flutter_core/lib/models/platform_types.dart',
      'enum PrimeCareForm { missingFixture }');
    write('packages/flutter_core/lib/src/registry/dynamic_adapter_resolver.dart',
      'Object resolveFixture() => Object();');
    write('.agents/governance/blueprints.yaml', '''
blueprints:
  - id: fixture
    required_components:
      - id: fixture-required-button
registries:
  - id: registry.auditor
    mapped_blueprints:
      - screen_id: fixture.missing
        blueprint_id: fixture
      - screen_id: fixture.present
        blueprint_id: fixture
''');
    write('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart', '''
class CoreGovernanceRegistry {
  static final screens = {
    'SCREEN_PRESENT': ScreenMetadata(id: 'SCREEN_PRESENT', routePath: '/fixture',
      implementedComponents: []),
  };
}
''');
    // Comments alone must never become runtime verification credit.
    write('lib/fixture.dart', '// UIAdapter RoleGuard trackScreenView RouteRegistry');
    screens = {
      'FIXTURE_KEY': const ScreenMetadata(id: 'FIXTURE_ID', title: 'Fixture',
        routePath: '/fixture', sourcePath: 'lib/fixture.dart', storyPoints: 0),
      'FIXTURE_DUPLICATE': const ScreenMetadata(id: 'FIXTURE_DUPLICATE', title: 'Duplicate',
        routePath: '/fixture', sourcePath: 'lib/fixture.dart', storyPoints: 0),
    };
  });
  tearDown(() async => root.delete(recursive: true));

  test('global remediation preserves routes, roles, providers and implementation evidence', () async {
    final files = snapshot();
    final metadata = {for (final entry in screens.entries) entry.key: entry.value.toJson()};
    final expected = [
      ...RegistryIntegrityService.inspect(screens),
      ...await auditor.auditFormProviderParity(),
      ...await auditor.auditScreenRegistryParity(),
      ...await auditor.auditNetworkSecurity(),
      ...await auditor.auditBankGradeSecurityCompliance(),
      ...await auditor.auditTranslationParity(screens),
      ...await auditor.auditArticleCompliance(screens),
      ...await auditor.auditFeatureVerification(screens),
    ];
    final result = await GovernanceRemediationEngine(null, projectRoot: root.path)
      .executeGlobalRemediation(screens: screens);
    expect(expected.any((i) => i.id.startsWith('registry_duplicate_route_')), isTrue);
    expect(result.issuesDetected, expected.length);
    expect(result.issuesResolved, 0);
    expect(result.resolutionLogs.any((line) => line.startsWith('[PENDING]')), isTrue);
    expect(result.resolutionLogs.any((line) => line.startsWith('[RESOLVED]')), isFalse);
    expect(snapshot(), files);
    expect({for (final entry in screens.entries) entry.key: entry.value.toJson()}, metadata);
  });

  test('missing providers, registrations and components require actual implementation', () async {
    final issues = [...await auditor.auditFormProviderParity(),
      ...await auditor.auditScreenRegistryParity()];
    expect(issues.map((i) => i.metadata['type']).toSet(),
      {'missing_form_provider', 'missing_registration', 'structural_drift'});
    expect(issues.every((i) => !i.autoRemediable), isTrue);
  });

  test('source strings produce pending candidates rather than verification or auto-fixes', () async {
    final before = screens['FIXTURE_KEY']!.toJson();
    final issues = await auditor.auditFeatureVerification({'FIXTURE_KEY': screens['FIXTURE_KEY']!});
    expect(issues.length, 4);
    expect(issues.every((i) => !i.autoRemediable), isTrue);
    expect(issues.every((i) => i.suggestion.contains('source string is not verification evidence')), isTrue);
    expect(screens['FIXTURE_KEY']!.toJson(), before);
  });

  test('metadata parity reads implicit, const and new constructors consistently', () async {
    const path = 'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart';
    final original = File('${root.path}/$path').readAsStringSync();
    for (final prefix in ['', 'const ', 'new ']) {
      write(path, original.replaceAll('ScreenMetadata(', '${prefix}ScreenMetadata('));
      final issues = await auditor.auditScreenRegistryParity();
      expect(issues.where((i) => i.metadata['type'] == 'missing_registration').length, 1,
        reason: 'Only the actually absent fixture may be reported missing: $prefix');
      expect(issues.where((i) => i.metadata['type'] == 'structural_drift').length, 1,
        reason: 'The registered fixture still lacks its required component: $prefix');
      expect(issues.any((i) => i.id == 'parity_audit_failed'), isFalse);
    }
  });

  test('legacy drift entry point cannot inject a generic provider or invented registration', () async {
    final before = snapshot();
    final resolved = await GovernanceRemediationEngine(null, projectRoot: root.path).remediateDrift();
    expect(resolved, 0);
    expect(snapshot(), before);
  });
}
