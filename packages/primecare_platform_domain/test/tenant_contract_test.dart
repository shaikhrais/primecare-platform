import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_platform_domain/primecare_platform_domain.dart';

void main() {
  test('tenant metadata is preserved', () {
    final tenant = PrimeCareTenant();
    expect(tenant.tenantId, 'primecare_hq');
    expect(tenant.name, 'PrimeCare');
  });
}
