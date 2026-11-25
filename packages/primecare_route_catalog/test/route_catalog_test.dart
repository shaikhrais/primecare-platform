import 'package:test/test.dart';
import 'package:primecare_route_catalog/primecare_route_catalog.dart';
void main() {
  test('public and private route names retain exact values', () {
    expect(CommonRoutes.login, '/login');
    expect(CommonRoutes.authCallback, '/auth/callback');
    expect(ClientRoutes.clientDashboard, '/offices/client/roles/client/dashboard');
    expect(AdminRoutes.adminDashboard, '/infrastructure/admin/dashboard');
  });
}
