import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_device_identity/primecare_device_identity.dart';
void main() { TestWidgetsFlutterBinding.ensureInitialized(); test('stored synthetic identity is preserved', () async { SharedPreferences.setMockInitialValues({'primecare_device_uuid':'fixture-device'}); await DeviceManager.instance.initialize(); expect(DeviceManager.instance.deviceId,'fixture-device'); }); }
