// Governance - Category: test | Purpose: Core implementation file for the Telemetry Sync Test platform logic.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';

class MockExecutionGateService extends ExecutionGateService {
  final List<Map<String, dynamic>> loggedMetadata = [];

  @override
  void passGate(
    ExecutionGateCategory category,
    String message, {
    bool silent = false,
    Map<String, dynamic>? metadata,
  }) {
    if (metadata != null) {
      loggedMetadata.add(metadata);
    }
  }
}

class TestTenant extends PlatformTenant {
  @override
  String get tenantId => 'test_tenant';

  @override
  String get name => 'Test Tenant';

  @override
  ThemeData get branding => ThemeData.light();
}

class TestModule extends PlatformModule {
  @override
  String get moduleId => 'test_module';

  @override
  String get name => 'Test Module';

  @override
  IconData get icon => Icons.info;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.admin];

  @override
  List<PrimeCareScreen> get screens => [];
}

void main() {
  group('Telemetry Audit', () {
    test(
      'AuraBehavioralTelemetry correctly captures tenantId and moduleId in metadata',
      () {
        final mockGate = MockExecutionGateService();
        final container = ProviderContainer(
          overrides: [executionGateProvider.overrideWithValue(mockGate)],
        );

        final telemetry = container.read(auraBehavioralTelemetryProvider);

        final tenant = TestTenant();
        final module = TestModule();
        final role = PlatformRole.admin;

        telemetry.updateGovernanceContext(
          tenant: tenant,
          module: module,
          role: role,
        );

        telemetry.logStructuralEvent(route: '/test', eventType: 'screen_mount');

        expect(mockGate.loggedMetadata.isNotEmpty, isTrue);

        final metadata = mockGate.loggedMetadata.first;
        expect(metadata['route'], '/test');
        expect(metadata['eventType'], 'screen_mount');
        expect(metadata['tenantId'], 'test_tenant');
        expect(metadata['tenantName'], 'Test Tenant');
        expect(metadata['moduleId'], 'test_module');
        expect(metadata['moduleName'], 'Test Module');
        expect(metadata['activeRole'], 'admin');
      },
    );
  });
}
