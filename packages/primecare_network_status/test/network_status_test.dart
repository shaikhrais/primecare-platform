import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_network_status/primecare_network_status.dart';

void main() {
  test('public connectivity provider supports offline and online fixture streams', () async {
    for (final online in [false, true]) {
      final container = ProviderContainer(overrides: [
        connectivityProvider.overrideWith((ref) => Stream.value(online)),
      ]);
      final subscription = container.listen(connectivityProvider, (_, _) {});
      try {
        expect(await container.read(connectivityProvider.future), online);
      } finally {
        subscription.close();
        container.dispose();
      }
    }
  });
}
