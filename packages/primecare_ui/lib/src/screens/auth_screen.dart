import '../localization/app_localizations.dart';
import '../admin/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:primecare_core/primecare_core.dart';
import '../auth/auth_controller.dart';
import '../layout/base_primecare_layout.dart';
import 'base_primecare_screen.dart';

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

/// The stateful Auth host retains credentials; its presentation inherits the
/// same responsive frame, language header and theme as role screens.
class _AuthLayout extends BasePrimecareScreen {
  @override
  final String title;
  final WidgetBuilder content;
  const _AuthLayout({required this.title, required this.content});
  @override
  Alignment get contentAlignment => Alignment.center;
  @override
  double contentWidth(PrimecareLayoutData layout) => layout.authContentWidth;
  @override
  Widget buildContent(BuildContext context) => content(context);
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
  AppStrings get strings => AppStrings.of(context);
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
    } on AuthFailure {
      _message = 'error.notConfigured';
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
      if (mounted) setState(() => _message = strings.failureKey(error));
    } catch (_) {
      if (mounted)
        setState(
          () => _message = 'error.authUnavailable',
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
          await auth.recover(_email.text);
          if (mounted)
            setState(() {
              _message = 'auth.recoverySent';
              _mode = 'reset';
            });
        case 'reset':
          await auth.reset(_email.text, _code.text, _newPassword.text);
          if (mounted)
            setState(() {
              _mode = 'login';
              _message = 'auth.resetDone';
            });
        case 'change':
          await auth.changePassword(_password.text, _newPassword.text);
          if (mounted)
            setState(() {
              _mode = 'login';
              _message = 'auth.changeDone';
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
      keyboardType: controller == _email
          ? TextInputType.emailAddress
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorMaxLines: 3,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return strings.text('required', {'field': label});
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
    return _AuthLayout(
      title: widget.title,
      content: (context) => SingleChildScrollView(
        padding: PrimecareLayoutData.of(context).pageInsets,
        child: AutofillGroup(
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        signedIn
                            ? strings.text('auth.signedIn')
                            : switch (_mode) {
                                'recover' => strings.text('auth.recover'),
                                'reset' => strings.text('auth.reset'),
                                'change' => strings.text('auth.changePassword'),
                                _ => strings.text('auth.signIn'),
                              },
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      if (signedIn) ...[
                        Text(strings.text('auth.identity', {'id': session.userId, 'role': strings.role(session.role)})),
                        if (session.role == 'admin') FilledButton(
                          onPressed: _busy ? null : () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => AdminScreen(request: _auth!.authorizedRequest))),
                          child: Text(strings.text('admin.open')),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _busy
                              ? null
                              : () => _run(_auth!.refreshSession),
                          child: Text(strings.text('auth.checkSession')),
                        ),
                        TextButton(
                          onPressed: _busy ? null : () => _select('change'),
                          child: Text(strings.text('auth.changePassword')),
                        ),
                        OutlinedButton(
                          onPressed: _busy ? null : () => _run(_auth!.logout),
                          child: Text(strings.text('auth.signOut')),
                        ),
                      ] else if (_auth != null) ...[
                        if (_mode != 'change') _field(_email, strings.text('auth.email')),
                        if (_mode == 'login' || _mode == 'change')
                          _field(
                            _password,
                            _mode == 'change' ? strings.text('auth.currentPassword') : strings.text('auth.password'),
                            secret: true,
                          ),
                        if (_mode == 'reset') _field(_code, strings.text('auth.resetCode')),
                        if (_mode == 'reset' || _mode == 'change') ...[
                          _field(_newPassword, strings.text('auth.newPassword'), secret: true),
                          Text(strings.text('error.password')),
                        ],
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _busy ? null : _submit,
                          child: Text(switch (_mode) {
                            'recover' => strings.text('auth.sendRecovery'),
                            'reset' => strings.text('auth.reset'),
                            'change' => strings.text('auth.changePassword'),
                            _ => strings.text('auth.signIn'),
                          }),
                        ),
                        if (_mode == 'login')
                          TextButton(
                            onPressed: _busy ? null : () => _select('recover'),
                            child: Text(strings.text('auth.forgot')),
                          ),
                        if (_mode == 'login')
                          TextButton(
                            onPressed: _busy ? null : () => _select('reset'),
                            child: Text(strings.text('auth.haveCode')),
                          ),
                        if (_mode != 'login')
                          TextButton(
                            onPressed: _busy ? null : () => _select('login'),
                            child: Text(
                              session != null
                                  ? strings.text('auth.backAccount')
                                  : strings.text('auth.backSignIn'),
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
                          child: Text(strings.text(_message!), semanticsLabel: strings.text(_message!)),
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
