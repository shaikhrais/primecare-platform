import 'package:test/test.dart';
import 'package:primecare_api_repository/primecare_api_repository.dart';

class Fixture extends BaseApiRepositoryBase<Object, String> {
  Fixture(Object client) : super(client, get: (path, {queryParameters}) async => 'GET $path',
    post: (path,{body}) async => 'POST $path', put: (path,{body}) async => 'PUT $path',
    patch: (path,{body}) async => 'PATCH $path', delete: (path) async => 'DELETE $path');
}

void main() {
  test('forwards methods to the injected transport', () async {
    final owner = Object();
    final repo = Fixture(owner);
    expect(identical(repo.client, owner), isTrue);
    expect(await repo.get('/fixture'), 'GET /fixture');
    expect(await repo.post('/fixture'), 'POST /fixture');
    expect(await repo.put('/fixture'), 'PUT /fixture');
    expect(await repo.patch('/fixture'), 'PATCH /fixture');
    expect(await repo.delete('/fixture'), 'DELETE /fixture');
  });
}
