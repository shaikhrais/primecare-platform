import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_models/src/models/psw_models.dart';
import 'package:primecare_models/src/models/result.dart';
import 'package:primecare_psw/primecare_psw.dart';

void main() {
  test('reads the existing PSW clients and tasks routes via the supplied port', () async {
    final paths = <String>[];
    final service = PswServiceBase((path) async {
      paths.add(path);
      return <dynamic>[];
    });
    expect(await service.getClients(), isA<Success<List<PswClient>>>());
    expect(await service.getTasks(), isA<Success<List<PswTask>>>());
    expect(paths, ['/psw/clients', '/psw/tasks']);
  });
  test('transport error remains a failed result', () async {
    final service = PswServiceBase((path) async => throw StateError('fixture failure'));
    expect(await service.getDashboardData(), isA<Failure<PswDashboardData>>());
  });
}
