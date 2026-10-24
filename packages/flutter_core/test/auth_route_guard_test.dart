import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/routes/route_guard.dart';

void main() {
  setUp(() => RouteGuard.synchronizePermissions(RouteGuard.defaultPermissions));
  tearDown(() => RouteGuard.synchronizePermissions(RouteGuard.defaultPermissions));
  for (final session in [(false, 'patient'), (true, null), (true, 'unregistered_test_role')]) {
    test('denied session $session uses the host application login', () {
      final result = RouteGuard.verify(requestedRoute: '/dashboard',
          isLoggedIn: session.$1, userRole: session.$2);
      expect(result.isAllowed, isFalse);
      expect(result.redirectRoute, '/login');
      expect(Uri.parse(result.redirectRoute!).hasAuthority, isFalse);
    });
  }

  for (final role in ['code_admin', 'not_admin', 'patient_admin_fake', 'super_ceo']) {
    test('$role cannot inherit a substring role', () {
      expect(RouteGuard.verify(requestedRoute: '/offices/corporate',
          isLoggedIn: true, userRole: role).isAllowed, isFalse);
    });
  }

  for (final route in ['/commonality', '/common-settings', '/common2/settings']) {
    test('prefix lookalike $route is denied', () {
      expect(RouteGuard.verify(requestedRoute: route,
          isLoggedIn: true, userRole: 'patient').isAllowed, isFalse);
    });
  }

  test('exact registered paths and their descendants remain allowed', () {
    for (final route in ['/common', '/common/settings']) {
      expect(RouteGuard.verify(requestedRoute: route,
          isLoggedIn: true, userRole: 'patient').isAllowed, isTrue);
    }
  });

  test('explicit server role permissions allow only their registered boundary', () {
    RouteGuard.synchronizePermissions({'code_admin': ['/platform/administration/']});
    for (final route in ['/platform/administration', '/platform/administration/tenants']) {
      expect(RouteGuard.verify(requestedRoute: route,
          isLoggedIn: true, userRole: 'code_admin').isAllowed, isTrue);
    }
    for (final route in ['/platform/administration-other', '/offices/corporate']) {
      expect(RouteGuard.verify(requestedRoute: route,
          isLoggedIn: true, userRole: 'code_admin').isAllowed, isFalse);
    }
  });

  test('empty server permissions revoke the preceding snapshot', () {
    RouteGuard.synchronizePermissions({'patient': ['/common']});
    expect(RouteGuard.verify(requestedRoute: '/common/settings',
        isLoggedIn: true, userRole: 'patient').isAllowed, isTrue);
    RouteGuard.synchronizePermissions({});
    expect(RouteGuard.verify(requestedRoute: '/common/settings',
        isLoggedIn: true, userRole: 'patient').isAllowed, isFalse);
  });

  test('caller mutation cannot expand a synchronized snapshot', () {
    final paths = ['/common'];
    final permissions = {'patient': paths};
    RouteGuard.synchronizePermissions(permissions);
    paths.add('/executive');
    permissions['ceo'] = ['/executive'];
    for (final role in ['patient', 'ceo']) {
      expect(RouteGuard.verify(requestedRoute: '/executive',
          isLoggedIn: true, userRole: role).isAllowed, isFalse);
    }
  });
}
