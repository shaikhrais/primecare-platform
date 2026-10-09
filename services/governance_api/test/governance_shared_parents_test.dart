import 'package:database_client/database_client.dart' as database;
import 'package:server_core/server_core.dart' as server;
import 'package:governance_api/src/core/base_controller.dart' as legacy_http;
import 'package:governance_api/src/core/base_repository.dart' as legacy_db;
import 'package:governance_api/src/routes/governance_routes.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

void main() {
  test('compatibility exports retain the exact shared parent types', () {
    expect(legacy_http.BaseController, server.BaseController);
    expect(legacy_db.BaseRepository, database.BaseRepository);
  });
  test('routers stay independent and sanity routes need no database', () async {
    final first = GovernanceRoutes.router;
    final second = GovernanceRoutes.router;
    expect(identical(first, second), isFalse);
    for (final router in [first, second]) {
      final root = await router(Request('GET', Uri.parse('https://api/')));
      expect(await root.readAsString(), 'Hello, World!\n');
      final echo = await router(Request('GET', Uri.parse('https://api/echo/original')));
      expect(await echo.readAsString(), 'original\n');
      expect((await router(Request('DELETE', Uri.parse('https://api/apps')))).statusCode, 404);
    }
  });
}
