import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Fake implements AuthTransport {
  String? path, token;
  Map<String, dynamic>? body;
  AuthFailure? failure;
  Map<String, dynamic> data = {
    'userId': 'u',
    'role': 'client',
    'status': 'authenticated',
    'token': 'a' * 43,
  };
  @override
  Future<Map<String, dynamic>> send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    this.path = path;
    this.body = body;
    this.token = token;
    if (failure != null) throw failure!;
    return data;
  }
}

class Workflow extends BaseAuthWorkflow {
  Workflow(super.transport);
}

void main() {
  late Fake fake;
  late Workflow auth;
  setUp(() {
    fake = Fake();
    auth = Workflow(fake);
  });
  test('login normalizes email, me accepts roles and carries token', () async {
    await auth.login(' USER@EXAMPLE.COM ', 'password');
    expect(fake.body!['email'], 'user@example.com');
    fake.data = {'userId': 'u', 'roles': 'client', 'status': 'authenticated'};
    await auth.refreshSession();
    expect(fake.token, 'a' * 43);
    expect(auth.session!.role, 'client');
  });
  test('malformed token cannot create session', () async {
    fake.data['token'] = 'bad';
    await expectLater(
      auth.login('a@b.com', 'password'),
      throwsA(isA<AuthFailure>()),
    );
    expect(auth.session, isNull);
  });
  test('revoked session clears local identity', () async {
    await auth.login('a@b.com', 'password');
    fake.failure = const AuthFailure('Invalid session', status: 401);
    await expectLater(auth.refreshSession(), throwsA(isA<AuthFailure>()));
    expect(auth.session, isNull);
  });
  test('failed logout permits retry with original token', () async {
    await auth.login('a@b.com', 'password');
    fake.failure = const AuthFailure('Unavailable', status: 503);
    await expectLater(auth.logout(), throwsA(isA<AuthFailure>()));
    expect(auth.session, isNotNull);
    fake.failure = null;
    await auth.logout();
    expect(fake.token, 'a' * 43);
    expect(auth.session, isNull);
  });
  test('recovery and reset use existing field contracts', () async {
    fake.data = {'message': 'Generic response'};
    expect(await auth.recover(' A@B.COM '), 'Generic response');
    await auth.reset('A@B.COM', 'abcdef123456', 'new-password-12');
    expect(fake.body, {
      'email': 'a@b.com',
      'code': 'ABCDEF123456',
      'newPassword': 'new-password-12',
    });
  });
  test('successful password change clears identity', () async {
    await auth.login('a@b.com', 'password');
    await auth.changePassword('password', 'new-password-12');
    expect(fake.body, {
      'currentPassword': 'password',
      'newPassword': 'new-password-12',
    });
    expect(auth.session, isNull);
  });
  test('invalid recovery input never reaches transport', () async {
    await expectLater(auth.recover('bad'), throwsA(isA<AuthFailure>()));
    expect(fake.path, isNull);
    await expectLater(
      auth.reset('a@b.com', 'bad', 'new-password-12'),
      throwsA(isA<AuthFailure>()),
    );
    expect(fake.path, isNull);
  });
  test(
    'password change requires session and enforces UTF-8 byte limit',
    () async {
      await expectLater(
        auth.changePassword('password', 'new-password-12'),
        throwsA(isA<AuthFailure>()),
      );
      expect(fake.path, isNull);
      await auth.login('a@b.com', 'password');
      await expectLater(
        auth.changePassword('password', 'é' * 37),
        throwsA(isA<AuthFailure>()),
      );
      expect(fake.path, '/login');
    },
  );
  test('temporary me failure preserves identity for retry', () async {
    await auth.login('a@b.com', 'password');
    fake.failure = const AuthFailure('Unavailable', status: 503);
    await expectLater(auth.refreshSession(), throwsA(isA<AuthFailure>()));
    expect(auth.session!.userId, 'u');
  });
  test('failed password mutation preserves session', () async {
    await auth.login('a@b.com', 'password');
    fake.failure = const AuthFailure('Invalid credentials', status: 401);
    await expectLater(
      auth.changePassword('wrong', 'new-password-12'),
      throwsA(isA<AuthFailure>()),
    );
    expect(auth.session!.userId, 'u');
  });
}
