import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_session_watchdog/primecare_session_watchdog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('host provider preserves the singleton lifecycle owner', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(identical(container.read(sessionWatchdogProvider), SessionWatchdog.instance), isTrue);
  });
}
