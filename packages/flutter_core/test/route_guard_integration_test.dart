import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/routes/route_guard.dart';

void main() {
  group('RouteGuard Boundary Enforcement Suite', () {

    // Seed the RouteGuard with a controlled mock permission subset
    setUp(() {
      RouteGuard.synchronizePermissions({
        'ceo': ['/corporate', '/common'],
        'rn': ['/clinic', '/common', '/dynamic'],
        'franchise_owner': ['/franchise', '/common'],
      });
    });

    test('Allow Unauthenticated Public Route', () {
      final result = RouteGuard.verify(
        requestedRoute: '/login',
        isLoggedIn: false,
        userRole: null,
      );
      expect(result.isAllowed, isTrue);
    });

    test('Block Unauthenticated Private Route', () {
      final result = RouteGuard.verify(
        requestedRoute: '/corporate/dashboard',
        isLoggedIn: false,
        userRole: null,
      );
      expect(result.isAllowed, isFalse);
      expect(result.redirectRoute, '/login');
    });

    test('Block Logged In User from Public Auth Routes', () {
      final result = RouteGuard.verify(
        requestedRoute: '/login',
        isLoggedIn: true,
        userRole: 'ceo',
      );
      // Expected to fail, forcing the router to redirect back to the home scope
      expect(result.isAllowed, isFalse);
    });

    test('Allow Authenticated User on Authorized Boundary', () {
      final result = RouteGuard.verify(
        requestedRoute: '/corporate/metrics',
        isLoggedIn: true,
        userRole: 'ceo',
      );
      expect(result.isAllowed, isTrue);
    });

    test('Block Authenticated User Crossing Boundary', () {
      final result = RouteGuard.verify(
        requestedRoute: '/clinic/patient_file',
        isLoggedIn: true,
        userRole: 'ceo', // CEO is bounded to /corporate and /common
      );
      expect(result.isAllowed, isFalse);
    });

    test('Allow Authenticated User on Common Boundary', () {
      final result = RouteGuard.verify(
        requestedRoute: '/common/settings',
        isLoggedIn: true,
        userRole: 'franchise_owner', 
      );
      expect(result.isAllowed, isTrue);
    });

    test('Block Undefined or Missing Roles', () {
      final result = RouteGuard.verify(
        requestedRoute: '/corporate/dashboard',
        isLoggedIn: true,
        userRole: 'mystery_hacker',
      );
      expect(result.isAllowed, isFalse);
    });
  });
}
