import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/routes/route_guard.dart';

void main() {
  for (final session in [(false, 'patient'), (true, null), (true, 'unregistered_test_role')]) {
    test('denied session $session uses the host application login', () {
      final result = RouteGuard.verify(requestedRoute: '/dashboard',
          isLoggedIn: session.$1, userRole: session.$2);
      expect(result.isAllowed, isFalse);
      expect(result.redirectRoute, '/login');
      expect(Uri.parse(result.redirectRoute!).hasAuthority, isFalse);
    });
  }
}
