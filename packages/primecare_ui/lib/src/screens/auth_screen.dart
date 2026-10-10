import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:primecare_core/primecare_core.dart';
import '../auth/auth_controller.dart';

/// All app-specific authentication screens inherit this shared form host.
abstract class BaseAuthScreen extends StatefulWidget {
  final String title;
  final AuthTransport? transport;
  const BaseAuthScreen({super.key, required this.title, this.transport});
  @override
  State<BaseAuthScreen> createState() => _AuthScreenState();
}

class AuthScreen extends BaseAuthScreen {
  const AuthScreen({super.key, required super.title, super.transport});
}

class _AuthScreenState extends State<BaseAuthScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _code = TextEditingController();
  final _newPassword = TextEditingController();
  http.Client? _client;
  AuthController? _auth;
  String _mode = 'login';
  String? _message;
  bool _busy = false;
  @override
  void initState() {
    super.initState();
    try {
      final transport =
          widget.transport ??
          HttpAuthTransport(
            const String.fromEnvironment('AUTH_API_URL'),
            _client = http.Client(),
          );
      _auth = AuthController(transport, () {
        if (mounted) setState(() {});
      });
    } on AuthFailure catch (error) {
      _message = error.message;
    }
  }

  @override
  void dispose() {
    _client?.close();
    _email.dispose();
    _password.dispose();
    _code.dispose();
    _newPassword.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() operation) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await operation();
    } on AuthFailure catch (error) {
      if (mounted) setState(() => _message = error.message);
    } catch (_) {
      if (mounted)
        setState(
          () => _message = 'Authentication unavailable. Please try again.',
        );
    } finally {
      if (mounted) {
        _password.clear();
        _newPassword.clear();
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    await _run(() async {
      final auth = _auth!;
      switch (_mode) {
        case 'recover':
          final message = await auth.recover(_email.text);
          if (mounted)
            setState(() {
              _message = message;
              _mode = 'reset';
            });
        case 'reset':
          await auth.reset(_email.text, _code.text, _newPassword.text);
          if (mounted)
            setState(() {
              _mode = 'login';
              _message = 'Password reset. Sign in again.';
            });
        case 'change':
          await auth.changePassword(_password.text, _newPassword.text);
          if (mounted)
            setState(() {
              _mode = 'login';
              _message = 'Password changed. Sign in again.';
            });
        default:
          await auth.login(_email.text, _password.text);
      }
    });
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool secret = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      controller: controller,
      enabled: !_busy,
      obscureText: secret,
      autocorrect: !secret,
      enableSuggestions: !secret,
      keyboardType: label == 'Email'
          ? TextInputType.emailAddress
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return '$label is required';
        return null;
      },
    ),
  );
  void _select(String mode) {
    setState(() {
      _mode = mode;
      _message = null;
    });
    _password.clear();
    _newPassword.clear();
    _form.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    final session = _auth?.session;
    final signedIn = session != null && _mode != 'change';
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: AutofillGroup(
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        signedIn
                            ? 'Signed in'
                            : switch (_mode) {
                                'recover' => 'Recover password',
                                'reset' => 'Reset password',
                                'change' => 'Change password',
                                _ => 'Sign in',
                              },
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      if (signedIn) ...[
                        Text('User: ${session.userId}\nRole: ${session.role}'),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _busy
                              ? null
                              : () => _run(_auth!.refreshSession),
                          child: const Text('Check session'),
                        ),
                        TextButton(
                          onPressed: _busy ? null : () => _select('change'),
                          child: const Text('Change password'),
                        ),
                        OutlinedButton(
                          onPressed: _busy ? null : () => _run(_auth!.logout),
                          child: const Text('Sign out'),
                        ),
                      ] else if (_auth != null) ...[
                        if (_mode != 'change') _field(_email, 'Email'),
                        if (_mode == 'login' || _mode == 'change')
                          _field(
                            _password,
                            _mode == 'change' ? 'Current password' : 'Password',
                            secret: true,
                          ),
                        if (_mode == 'reset') _field(_code, 'Reset code'),
                        if (_mode == 'reset' || _mode == 'change') ...[
                          _field(_newPassword, 'New password', secret: true),
                          const Text(
                            'Use at least 12 characters, up to 72 UTF-8 bytes.',
                          ),
                        ],
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _busy ? null : _submit,
                          child: Text(switch (_mode) {
                            'recover' => 'Send recovery instructions',
                            'reset' => 'Reset password',
                            'change' => 'Change password',
                            _ => 'Sign in',
                          }),
                        ),
                        if (_mode == 'login')
                          TextButton(
                            onPressed: _busy ? null : () => _select('recover'),
                            child: const Text('Forgot password?'),
                          ),
                        if (_mode == 'login')
                          TextButton(
                            onPressed: _busy ? null : () => _select('reset'),
                            child: const Text('Already have a reset code?'),
                          ),
                        if (_mode != 'login')
                          TextButton(
                            onPressed: _busy ? null : () => _select('login'),
                            child: Text(
                              session != null
                                  ? 'Back to account'
                                  : 'Back to sign in',
                            ),
                          ),
                      ],
                      if (_busy)
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: LinearProgressIndicator(),
                        ),
                      if (_message != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(_message!, semanticsLabel: _message),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
