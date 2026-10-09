import 'package:server_core/server_core.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:auth_api/routes.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:database_client/database_client.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

String? _bearerToken(Request request) {
  final header = request.headers['authorization'] ?? '';
  if (header.startsWith('Bearer ')) return header.substring(7).trim();
  return null;
}

String? _sessionToken(Request request) {
  final bearer = _bearerToken(request);
  if (bearer != null && bearer.isNotEmpty) return bearer;
  final cookies = request.headers['cookie'] ?? '';
  for (final cookie in cookies.split(';')) {
    final pair = cookie.trim().split('=');
    if (pair.length == 2 && pair.first == 'session_token') return pair.last;
  }
  return null;
}

String _hashToken(String token) =>
    sha256.convert(utf8.encode(token)).toString();

String _newToken() {
  final random = Random.secure();
  return base64UrlEncode(
    List<int>.generate(32, (_) => random.nextInt(256)),
  ).replaceAll('=', '');
}

Response _json(
  int code,
  Map<String, Object?> body, {
  Map<String, String>? headers,
}) => Response(
  code,
  body: jsonEncode(body),
  headers: {'content-type': 'application/json', ...?headers},
);

Future<void> main() async {
  await AuthApiHost().run();
}

class AuthApiHost extends BaseHttpServiceHost {
  AuthApiHost() : super(serviceName: 'auth-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();
    final router = Router();

    router.post('/login', (Request request) async {
      Map<String, dynamic> payload;
      try {
        payload =
            jsonDecode(await request.readAsString()) as Map<String, dynamic>;
      } catch (_) {
        return _json(400, {'error': 'Invalid request'});
      }
      final email = (payload['email'] as String?)?.trim().toLowerCase();
      final password = payload['password'];
      if (email == null ||
          email.isEmpty ||
          email.length > 254 ||
          password is! String ||
          password.isEmpty) {
        return _json(400, {'error': 'Email and password are required'});
      }

      final users = await db.query(
        'SELECT id, roles, password_hash, status FROM users WHERE LOWER(email) = @email LIMIT 1',
        substitutionValues: {'email': email},
      );
      if (users.isEmpty) return _json(401, {'error': 'Invalid credentials'});
      final user = users.first;
      final hash = user[2]?.toString() ?? '';
      var valid = false;
      if (hash.startsWith(r'$2')) {
        try {
          valid = BCrypt.checkpw(password, hash);
        } catch (_) {
          valid = false;
        }
      }
      if (!valid || user[3]?.toString().toLowerCase() != 'active') {
        return _json(401, {'error': 'Invalid credentials'});
      }

      final token = _newToken();
      await db.query(
        'INSERT INTO auth_sessions (token_hash, user_id, expires_at) '
        "VALUES (@hash, @id, NOW() + INTERVAL '12 hours')",
        substitutionValues: {'hash': _hashToken(token), 'id': user[0]},
      );
      return _json(
        200,
        {
          'userId': user[0].toString(),
          'role': user[1].toString(),
          'token': token,
          'status': 'authenticated',
        },
        headers: {
          'set-cookie':
              'session_token=$token; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=43200',
          'cache-control': 'no-store',
        },
      );
    });

    router.get('/me', (Request request) async {
      final token = _sessionToken(request);
      if (token == null || token.isEmpty)
        return _json(401, {'error': 'No session'});
      final users = await db.query(
        'SELECT u.id, u.roles FROM auth_sessions s '
        'JOIN users u ON u.id = s.user_id '
        'WHERE s.token_hash = @hash AND s.expires_at > NOW() '
        "AND LOWER(u.status) = 'active' LIMIT 1",
        substitutionValues: {'hash': _hashToken(token)},
      );
      if (users.isEmpty) return _json(401, {'error': 'Invalid session'});
      return _json(
        200,
        {
          'userId': users.first[0].toString(),
          'roles': users.first[1].toString(),
          'status': 'authenticated',
        },
        headers: {'cache-control': 'no-store'},
      );
    });

    router.post('/logout', (Request request) async {
      final token = _sessionToken(request);
      if (token != null && token.isNotEmpty) {
        await db.query(
          'DELETE FROM auth_sessions WHERE token_hash = @hash',
          substitutionValues: {'hash': _hashToken(token)},
        );
      }
      return _json(
        200,
        {'status': 'signed_out'},
        headers: {
          'set-cookie':
              'session_token=; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=0',
          'cache-control': 'no-store',
        },
      );
    });

    router.get(
      '/health',
      (Request request) => _json(200, {'status': 'healthy'}),
    );

    router.mount('/', ApiRoutes().router.call);

    return router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('Auth API serving at port ${server.port}');
  }
}
