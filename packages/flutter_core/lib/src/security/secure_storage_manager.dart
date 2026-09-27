// Governance - Category: service | Purpose: [SecureStorageManager] - Provides hardware-backed encrypted storage. Essential for storing tokens, fingerprints, and ...
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// [SecureStorageManager] - Provides hardware-backed encrypted storage.
/// Essential for storing tokens, fingerprints, and PII on trusted devices.
class SecureStorageManager {
  static final SecureStorageManager instance = SecureStorageManager._internal();
  SecureStorageManager._internal();

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Securely writes a value.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a secure value.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Deletes a secure value.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Wipes all secure data (e.g. on logout or compromise).
  Future<void> wipe() async {
    await _storage.deleteAll();
  }
}
