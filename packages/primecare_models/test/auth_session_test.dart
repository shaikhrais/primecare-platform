import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

void main() {
  test('API login serializer and UI decoder share identity', () {
    const identity = AuthSession('user', 'client');
    expect(identity, isA<BaseEntity<String>>());
    expect(identity.toLoginJson('token'), {
      'userId': 'user',
      'role': 'client',
      'token': 'token',
      'status': 'authenticated',
    });
    expect(AuthSession.fromJson(identity.toLoginJson('token')).userId, 'user');
  });
  test('me serialization preserves plural roles and never exposes token', () {
    const identity = AuthSession('user', 'client');
    expect(identity.toJson(), {
      'userId': 'user',
      'roles': 'client',
      'status': 'authenticated',
    });
    expect(AuthSession.fromJson(identity.toJson()).role, 'client');
  });
  test('invalid identity is rejected', () {
    for (final payload in <Map<String, dynamic>>[
      {},
      {'userId': 42, 'role': 'client', 'status': 'authenticated'},
      {'userId': 'user', 'roles': '', 'status': 'authenticated'},
      {'userId': 'user', 'roles': 'client', 'status': 'signed_out'},
    ]) {
      expect(() => AuthSession.fromJson(payload), throwsFormatException);
    }
  });
}
