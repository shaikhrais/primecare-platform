import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_auth_storage/primecare_auth_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('native web-only storage adapter is unavailable and manager is stable', () {
    expect(getLocalStorageItem('synthetic-fixture'), isNull);
    expect(identical(SecureStorageManager.instance, SecureStorageManager.instance), isTrue);
  });
}
