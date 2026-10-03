import 'dart:convert';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

/// Shared native/web recovery UI; only the server can verify recovery codes.
class PasswordRecoveryForm extends ConsumerStatefulWidget {
  final bool reset;
  const PasswordRecoveryForm({super.key, required this.reset});
  @override
  ConsumerState<PasswordRecoveryForm> createState() => _PasswordRecoveryFormState();
}

class _PasswordRecoveryFormState extends ConsumerState<PasswordRecoveryForm> {
  final _email = TextEditingController();
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;
  bool _success = false;
  String? _message;
  @override
  void dispose() {
    for (final controller in [_email, _code, _password, _confirm]) { controller.dispose(); }
    super.dispose();
  }
  Future<void> _submit() async {
    if (_busy) return;
    final email = _email.text.trim().toLowerCase();
    String? error;
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email) || email.length > 254) {
      error = 'Enter a valid email address.';
    } else if (widget.reset && !RegExp(r'^[A-Fa-f0-9]{12}$').hasMatch(_code.text.trim())) {
      error = 'Enter the 12-character code from your email.';
    } else if (widget.reset && (_password.text.length < 12 || utf8.encode(_password.text).length > 72)) {
      error = 'Use at least 12 characters, with a maximum of 72 bytes.';
    } else if (widget.reset && _password.text != _confirm.text) {
      error = 'Passwords do not match.';
    }
    if (error != null) { setState(() { _message = error; _success = false; }); return; }
    setState(() { _busy = true; _message = null; _success = false; });
    try {
      final response = await ref.read(apiClientProvider).post(
        ApiConfig.endpoints[widget.reset ? 'resetPassword' : 'forgotPassword']!,
        body: {'email': email, if (widget.reset) ...{'code': _code.text.trim().toUpperCase(), 'newPassword': _password.text}},
      );
      if (!mounted) return;
      final data = response.data;
      setState(() {
        _success = response.statusCode == 200;
        _message = _success
            ? (widget.reset ? 'Password reset. Sign in with your new password.' : 'If an active account matches, a code will be emailed. Check your inbox and spam folder.')
            : (data is Map && data['error'] is String ? data['error'] as String : 'Cannot reach password recovery. Check your connection and try again.');
      });
      if (_success && widget.reset) { _password.clear(); _confirm.clear(); _code.clear(); }
    } catch (_) {
      if (mounted) setState(() { _message = 'Cannot reach password recovery. Please try again.'; });
    } finally { if (mounted) setState(() { _busy = false; }); }
  }
  Widget _field(String label, TextEditingController controller, {bool secret = false, TextInputType? keyboard}) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: TextField(
        controller: controller, enabled: !_busy, obscureText: secret, keyboardType: keyboard,
        autocorrect: !secret, enableSuggestions: !secret,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ));
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _field('Email', _email, keyboard: TextInputType.emailAddress),
    if (widget.reset) ...[
      _field('Reset code from email', _code),
      _field('New password (12+ characters)', _password, secret: true),
      _field('Confirm new password', _confirm, secret: true),
    ],
    if (_message != null) Padding(padding: const EdgeInsets.only(bottom: 16), child: Semantics(liveRegion: true, child: Text(_message!))),
    FilledButton(onPressed: _busy ? null : _submit, child: Text(_busy ? 'Please wait…' : widget.reset ? 'Reset password' : 'Email reset code')),
    TextButton(onPressed: _busy ? null : () => context.go(widget.reset ? '/forgot-password' : '/reset-password'), child: Text(widget.reset ? 'Request a new code' : 'I have a reset code')),
    if (_success && widget.reset) TextButton(onPressed: () => context.go('/login'), child: const Text('Sign in')),
  ]);
}
