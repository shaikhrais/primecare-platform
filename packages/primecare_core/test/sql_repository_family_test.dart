import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Queries implements SqlExecutor<Object> {
  final calls = <(String, Map<String, dynamic>?)>[];
  final result = Future<Object>.value(Object());
  Object? error;
  @override
  Future<Object> query(String sql, {Map<String, dynamic>? substitutionValues}) {
    calls.add((sql, substitutionValues));
    return error == null ? result : Future<Object>.error(error!);
  }
}

class Clients extends BaseClientSqlRepository<Queries, Object> {
  Clients(super.database);
}

class Providers extends BaseProviderSqlRepository<Queries, Object> {
  Providers(super.database);
}

class Visits extends BaseVisitSqlRepository<Queries, Object> {
  Visits(super.database);
}

class Scheduling extends BaseSchedulingSqlRepository<Queries, Object> {
  Scheduling(super.database);
}

class Billing extends BaseBillingSqlRepository<Queries, Object> {
  Billing(super.database);
}

class Compliance extends BaseComplianceSqlRepository<Queries, Object> {
  Compliance(super.database);
}

void main() {
  test('all read queries retain SQL and original future identity', () async {
    final db = Queries();
    final cases = <(Future<Object> Function(), String)>[
      (Clients(db).listClients, 'SELECT * FROM clients'),
      (Providers(db).listProviders, 'SELECT * FROM providers'),
      (Visits(db).listVisits, 'SELECT * FROM visits ORDER BY visit_date DESC'),
      (Billing(db).listInvoices, 'SELECT * FROM invoices'),
      (
        Compliance(db).listAudits,
        'SELECT * FROM compliance_audits ORDER BY created_at DESC',
      ),
    ];
    for (final (run, sql) in cases) {
      expect(run(), same(db.result));
      expect(db.calls.last, (sql, null));
    }
    expect(Scheduling(db).listSchedules(), same(db.result));
    expect(db.calls.last.$1, contains('JOIN clients c ON s.client_id = c.id'));
    expect(
      db.calls.last.$1,
      contains('JOIN providers p ON s.provider_id = p.id'),
    );
    final provider = Providers(db);
    expect(provider.database, same(db));
    expect(provider.findProvider('p'), same(db.result));
    expect(db.calls.last.$1, 'SELECT * FROM providers WHERE id = @id');
    expect(db.calls.last.$2, {'id': 'p'});
    await db.result;
  });
  test('write parameter mapping and metadata JSON preserve legacy values', () {
    final db = Queries();
    expect(
      Clients(
        db,
      ).createClient({'first_name': 'A', 'last_name': 'B', 'email': 'a@b'}),
      same(db.result),
    );
    expect(db.calls.last.$2, {
      'firstName': 'A',
      'lastName': 'B',
      'email': 'a@b',
    });
    expect(
      db.calls.last.$1,
      contains('VALUES (@firstName, @lastName, @email)'),
    );
    expect(
      Visits(db).createVisit({
        'client_id': 'c',
        'provider_id': 'p',
        'status': 'ignored',
      }),
      same(db.result),
    );
    expect(db.calls.last.$2, {
      'clientId': 'c',
      'providerId': 'p',
      'status': 'started',
    });
    expect(db.calls.last.$1, contains('NOW()'));
    Compliance(db).createFinding({
      'category': 'x',
      'severity': 'high',
      'message': 'm',
      'metadata': {'count': 2},
    });
    expect(db.calls.last.$2, {
      'category': 'x',
      'severity': 'high',
      'message': 'm',
      'metadata': '{"count":2}',
    });
    Compliance(db).createFinding({});
    expect(db.calls.last.$2, {
      'category': null,
      'severity': null,
      'message': null,
      'metadata': '{}',
    });
  });
  test('driver errors pass through unchanged', () async {
    final error = StateError('driver');
    final db = Queries()..error = error;
    await expectLater(Clients(db).listClients(), throwsA(same(error)));
    await expectLater(Providers(db).findProvider('p'), throwsA(same(error)));
    await expectLater(Visits(db).createVisit({}), throwsA(same(error)));
  });
}
