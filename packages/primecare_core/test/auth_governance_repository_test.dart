import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Queries implements SqlExecutor<Object> {
  final result = Future<Object>.value(Object());
  final calls = <(String, Map<String, dynamic>?)>[];
  @override
  Future<Object> query(String sql, {Map<String, dynamic>? substitutionValues}) {
    calls.add((sql, substitutionValues));
    return result;
  }
}

class Auth extends BaseAuthSqlRepository<Queries, Object> {
  Auth(super.database);
}

class Governance
    extends BaseGovernanceSqlRepository<List<Map<String, dynamic>>> {
  final calls = <(String, bool, Map<String, dynamic>?)>[];
  final rows = <Map<String, dynamic>>[
    {'id': 1},
  ];
  Object? error;
  @override
  Future<List<Map<String, dynamic>>> executeSql(
    String sql, {
    bool named = false,
    Map<String, dynamic>? parameters,
  }) async {
    calls.add((sql, named, parameters));
    if (error != null) throw error!;
    return rows;
  }

  @override
  List<Map<String, dynamic>> mapResult(List<Map<String, dynamic>> result) =>
      result;
}

void main() {
  test('auth queries retain email hash ID and session policy SQL', () {
    final db = Queries();
    final auth = Auth(db);
    expect(auth.findUser('Exact@Email'), same(db.result));
    expect(db.calls.last.$2, {'email': 'Exact@Email'});
    expect(db.calls.last.$1, contains('LOWER(email) = @email'));
    expect(auth.createSession('hash', 7), same(db.result));
    expect(db.calls.last.$2, {'hash': 'hash', 'id': 7});
    expect(db.calls.last.$1, contains("INTERVAL '12 hours'"));
    auth.findSession('hash');
    expect(db.calls.last.$2, {'hash': 'hash'});
    expect(db.calls.last.$1, contains('s.expires_at > NOW()'));
    expect(db.calls.last.$1, contains("LOWER(u.status) = 'active'"));
    auth.deleteSession('hash');
    expect(
      db.calls.last.$1,
      'DELETE FROM auth_sessions WHERE token_hash = @hash',
    );
  });
  test('all governance reads retain raw execution and mapping', () async {
    final gov = Governance();
    final cases = <(Future<List<Map<String, dynamic>>> Function(), String)>[
      (gov.getApps, 'apps'),
      (gov.getRoles, 'roles'),
      (gov.getFeatures, 'features'),
      (gov.getApis, 'apis'),
      (gov.getScreens, 'screens'),
      (gov.getModules, 'modules'),
      (gov.getRoutes, 'routes'),
      (gov.getPermissions, 'permissions'),
      (gov.getLanguages, 'languages'),
      (gov.getStatuses, 'statuses'),
    ];
    for (final (run, table) in cases) {
      expect(await run(), same(gov.rows));
      expect(gov.calls.last.$1, 'SELECT * FROM $table');
      expect(gov.calls.last.$2, isFalse);
      expect(gov.calls.last.$3, isNull);
    }
    await gov.getEvents(limit: 3);
    expect(gov.calls.last.$3, {'limit': 3});
    expect(
      gov.calls.last.$1,
      contains('ORDER BY created_at DESC LIMIT @limit'),
    );
  });
  test(
    'all governance creates retain named SQL and field parameter maps',
    () async {
      final gov = Governance();
      final cases = <(Future<void> Function(dynamic), String, List<String>)>[
        (gov.createApp, 'apps', ['name', 'type', 'status']),
        (gov.createRole, 'roles', ['name', 'code', 'status']),
        (gov.createModule, 'modules', ['name', 'app_id', 'priority']),
        (
          gov.createFeature,
          'features',
          [
            'requested_by',
            'feature_name',
            'intent',
            'app_name',
            'screens',
            'apis',
            'roles',
            'status',
          ],
        ),
        (gov.createScreen, 'screens', ['name']),
        (gov.createRoute, 'routes', ['path']),
        (gov.createApi, 'apis', ['endpoint']),
        (gov.createPermission, 'permissions', ['code']),
        (gov.createLanguage, 'languages', ['name']),
        (gov.createStatus, 'statuses', ['name']),
      ];
      for (final (run, table, fields) in cases) {
        final data = {for (final field in fields) field: 'value-$field'};
        await run(data);
        expect(gov.calls.last.$1, startsWith('INSERT INTO $table '));
        expect(gov.calls.last.$2, isTrue);
        expect(gov.calls.last.$3, data);
      }
    },
  );
  test(
    'governance remediation event metadata and failures preserve behavior',
    () async {
      final gov = Governance();
      await gov.remediate4KStandard();
      expect(gov.calls.last.$1, contains('design_size_width = 3840'));
      expect(gov.calls.last.$2, isFalse);
      final metadata = <String, dynamic>{'source': 'test'};
      await gov.logEvent(
        type: 'audit',
        message: 'm',
        level: 'info',
        metadata: metadata,
      );
      expect(gov.calls.last.$3!['metadata'], same(metadata));
      expect(gov.calls.last.$2, isFalse);
      final error = StateError('driver');
      gov.error = error;
      await expectLater(gov.getApps(), throwsA(same(error)));
      await expectLater(gov.createApp(<String,dynamic>{}), throwsA(same(error)));
    },
  );
}
