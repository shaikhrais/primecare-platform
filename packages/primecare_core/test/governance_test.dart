import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Intent extends BaseScreenIntent {
  @override
  final String name;
  @override
  String get title => 'Title';
  @override
  final PlatformRole? requiredRole;
  @override
  final List<dynamic> dependencies;
  Intent(this.name, {this.requiredRole, this.dependencies = const []});
}

class RoutedIntent extends Intent {
  @override
  final String route;
  RoutedIntent(
    super.name,
    this.route, {
    super.requiredRole,
    super.dependencies,
  });
}

class Reader {
  final Map<Object, Object?> values;
  final reads = <Object>[];
  Reader(this.values);
  Object? read(Object key) {
    reads.add(key);
    final value = values[key];
    if (value is Exception) throw value;
    return value;
  }
}

void main() {
  test(
    'intent defaults retain existing literal routes and recovery policy',
    () {
      final intent = Intent('hello_world');
      expect(intent.intentId, 'hello-world');
      expect(intent.route, r'/$name');
      expect(intent.subtitle, r'Governed Portal for $title');
      expect(
        intent.resiliencePolicy.strategy,
        ScreenRecoveryStrategy.softReset,
      );
      expect(intent.resiliencePolicy.retryDelay, const Duration(seconds: 2));
      expect(intent.resiliencePolicy.maxRetries, 3);
      expect(intent.requiredRole, isNull);
    },
  );
  test('readiness stops at the first failed dependency', () {
    final intent = Intent('example', dependencies: ['a', 'b']);
    final nullReader = Reader({'a': null, 'b': 1});
    expect(intent.verifyReady(nullReader).message, 'Dependency String is null');
    expect(nullReader.reads, ['a']);
    final failing = Reader({'a': Exception('broken')});
    expect(intent.verifyReady(failing).message, contains('broken'));
    final healthy = Reader({'a': 1, 'b': false});
    expect(intent.verifyReady(healthy).isReady, isTrue);
    expect(healthy.reads, ['a', 'b']);
  });
  test('registry keeps overwrite, role and snapshot semantics', () {
    final registry = BaseGovernanceRegistry<RoutedIntent>();
    final first = RoutedIntent('first', '/one', requiredRole: PlatformRole.ceo);
    final second = RoutedIntent(
      'second',
      '/one',
      requiredRole: PlatformRole.coo,
    );
    registry.register(first);
    registry.register(second);
    expect(registry.getIntentByRoute('/one'), same(second));
    expect(registry.getIntentByRole(PlatformRole.ceo.nameSnake), same(first));
    expect(registry.getIntentByRole(PlatformRole.coo.nameSnake), same(second));
    registry.register(first, role: 'override');
    expect(registry.getIntentByRole('override'), same(first));
    final snapshot = registry.getAllIntents()..clear();
    expect(snapshot, isEmpty);
    expect(registry.getAllIntents(), [first]);
    registry.flush();
    expect(registry.registeredRoutes, isEmpty);
    expect(registry.getIntentByRole('override'), isNull);
  });
  test(
    'health sweep and audit preserve registered order and role universe',
    () {
      final registry = BaseGovernanceRegistry<RoutedIntent>();
      registry.register(
        RoutedIntent('first', '/one', requiredRole: PlatformRole.ceo),
      );
      registry.register(
        RoutedIntent('second', '/two', dependencies: ['missing']),
      );
      final reports = registry.performHealthSweep(Reader({}));
      expect(reports.map((r) => r.route), ['/one', '/two']);
      expect(reports.map((r) => r.isHealthy), [true, false]);
      final universe = PlatformRole.values
          .where(
            (r) =>
                r != PlatformRole.unknown &&
                r != PlatformRole.system &&
                r.index < PlatformRole.corporate.index,
          )
          .toList();
      final audit = registry.performDomainAudit();
      expect(audit.totalRoles, universe.length);
      expect(audit.realized, [PlatformRole.ceo]);
      expect(audit.pending, universe.where((r) => r != PlatformRole.ceo));
      expect(audit.integrityScore, closeTo(100 / universe.length, 1e-12));
      expect(audit.orphans, isEmpty);
    },
  );
  test(
    'role registry returns shared metadata and keeps case-insensitive filters',
    () {
      final all = RoleRegistry.getAllRoles();
      expect(all, isNotEmpty);
      for (final metadata in all) {
        expect(RoleRegistry.getMetadata(metadata.role), same(metadata));
        expect(metadata.isAdmin, metadata.accessLevel == 'admin');
        expect(
          metadata.isCompliance,
          ['admin', 'compliance'].contains(metadata.accessLevel),
        );
      }
      final ceo = RoleRegistry.getMetadata(PlatformRole.ceo)!;
      expect(
        RoleRegistry.getRolesByCategory(ceo.category.toUpperCase()),
        contains(ceo),
      );
      expect(
        RoleRegistry.getRolesByPortal(ceo.defaultPortal.toUpperCase()),
        contains(ceo),
      );
      expect(RoleRegistry.getMetadata(PlatformRole.unknown), isNull);
      final expectedCoverage = PlatformRole.values
          .where(
            (r) =>
                r != PlatformRole.unknown &&
                r.index < PlatformRole.corporate.index,
          )
          .every((r) => RoleRegistry.getMetadata(r) != null);
      expect(RoleRegistry.verifyCompleteCoverage(), expectedCoverage);
    },
  );
}
