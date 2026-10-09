import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:governance_api/src/routes/governance_routes.dart';

void main() {
  test(
    'static interface still returns fresh routers with original public routes',
    () async {
      final first = GovernanceRoutes.router;
      final second = GovernanceRoutes.router;
      expect(identical(first, second), isFalse);
      for (final router in [first, second]) {
        final root = await router(
          Request('GET', Uri.parse('https://service/')),
        );
        expect(root.statusCode, 200);
        expect(await root.readAsString(), 'Hello, World!\n');
        final echo = await router(
          Request('GET', Uri.parse('https://service/echo/existing')),
        );
        expect(await echo.readAsString(), 'existing\n');
        expect(
          (await router(
            Request('DELETE', Uri.parse('https://service/')),
          )).statusCode,
          404,
        );
        expect(
          (await router(
            Request('GET', Uri.parse('https://service/unknown')),
          )).statusCode,
          404,
        );
      }
    },
  );
}
