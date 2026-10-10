import 'dart:convert';
import 'package:primecare_models/primecare_models.dart';

/// Transport-neutral authentication contract shared by application adapters.
abstract interface class AuthTransport {
  Future<Map<String, dynamic>> send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    String? token,
  });
}

class AuthFailure implements Exception {
  final String message;
  final int? status;
  const AuthFailure(this.message, {this.status});
  @override
  String toString() => message;
}

/// Owns credentials, session validation and recovery independently of Flutter.
/// Tokens live only in memory; every session check is authorized by the API.
abstract class BaseAuthWorkflow {
  final AuthTransport transport;
  BaseAuthWorkflow(this.transport);
  String? _token;
  AuthSession? _session;
  AuthSession? get session => _session;
  void changed() {}
  String _email(String value) => value.trim().toLowerCase();
  AuthSession _readSession(Map<String, dynamic> data) {
    try {
      return AuthSession.fromJson(data);
    } on FormatException {
      throw const AuthFailure('Invalid authentication response');
    }
  }

  Future<void> login(String email, String password) async {
    if (_email(email).isEmpty || password.isEmpty) {
      throw const AuthFailure('Email and password are required');
    }
    _validateEmail(email);
    if (utf8.encode(password).length > 72) {
      throw const AuthFailure('Password exceeds 72 UTF-8 bytes');
    }
    final data = await transport.send(
      'POST',
      '/login',
      body: {'email': _email(email), 'password': password},
    );
    final next = _readSession(data);
    final token = data['token'];
    if (token is! String || !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(token)) {
      throw const AuthFailure('Invalid authentication response');
    }
    _token = token;
    _session = next;
    changed();
  }

  Future<void> refreshSession() async {
    if (_token == null) return;
    try {
      _session = _readSession(
        await transport.send('GET', '/me', token: _token),
      );
    } on AuthFailure catch (error) {
      if (error.status == 401) {
        _token = null;
        _session = null;
      }
      rethrow;
    } finally {
      changed();
    }
  }

  Future<void> logout() async {
    // Keep credentials until revocation succeeds so failed logout can be retried.
    await transport.send('POST', '/logout', token: _token);
    _token = null;
    _session = null;
    changed();
  }

  void _validateEmail(String email) {
    final normalized = _email(email);
    if (normalized.length > 254 ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(normalized)) {
      throw const AuthFailure('Enter a valid email');
    }
  }

  void _validateNewPassword(String password) {
    if (password.length < 12 || utf8.encode(password).length > 72) {
      throw const AuthFailure(
        'Use at least 12 characters, up to 72 UTF-8 bytes.',
      );
    }
  }

  Future<String> recover(String email) async {
    _validateEmail(email);
    final data = await transport.send(
      'POST',
      '/forgot-password',
      body: {'email': _email(email)},
    );
    return data['message'] is String
        ? data['message'] as String
        : 'Recovery instructions requested.';
  }

  Future<void> reset(String email, String code, String password) async {
    _validateEmail(email);
    _validateNewPassword(password);
    if (!RegExp(r'^[A-F0-9]{12}$').hasMatch(code.trim().toUpperCase())) {
      throw const AuthFailure(
        'Enter the 12-character reset code from your email',
      );
    }
    await transport.send(
      'POST',
      '/reset-password',
      body: {
        'email': _email(email),
        'code': code.trim().toUpperCase(),
        'newPassword': password,
      },
    );
    _token = null;
    _session = null;
    changed();
  }

  Future<void> changePassword(String current, String next) async {
    if (_token == null)
      throw const AuthFailure('Sign in before changing your password');
    _validateNewPassword(next);
    if (current.isEmpty ||
        utf8.encode(current).length > 72 ||
        current == next) {
      throw const AuthFailure(
        'Enter your current password and a different new password',
      );
    }
    await transport.send(
      'POST',
      '/change-password',
      token: _token,
      body: {'currentPassword': current, 'newPassword': next},
    );
    _token = null;
    _session = null;
    changed();
  }
}
