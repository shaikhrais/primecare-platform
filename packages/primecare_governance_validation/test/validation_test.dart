import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance_validation/primecare_governance_validation.dart';
import 'package:primecare_models/primecare_models.dart';
import 'package:primecare_screen_models/primecare_screen_models.dart';
void main() {
  test('missing API stays noncompliant and unregistered access stays denied', () {
    final screen = ScreenMetadata(id: 'fixture', title: 'Fixture', requiredApis: ['missing']);
    expect(PlatformParityEngine.checkScreenParity(screen, {}).isCompliant, isFalse);
    expect(RegistryScanner.findRogueEndpoints(['/fixture'], {}), ['/fixture']);
    expect(() => Governed.api('missing', 'fixture', registry: {}), throwsA(isA<GovernanceException>()));
    const metadata = ApiMetadata(id: 'fixture', endpoint: '/fixture');
    expect(RegistryScanner.findOrphanedMetadata(['/fixture'], {'fixture': metadata}), isEmpty);
  });
}
