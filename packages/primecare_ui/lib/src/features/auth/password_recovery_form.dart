import 'dart:convert';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../localization/auth_screen_text.dart';
import 'auth_navigation.dart';

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
  String? _messageKey;
  String text(String key) => authScreenText(context, key, recovery: true);
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
      error = 'invalid_email';
    } else if (widget.reset && !RegExp(r'^[A-Fa-f0-9]{12}$').hasMatch(_code.text.trim())) {
      error = 'invalid_code';
    } else if (widget.reset && (_password.text.length < 12 || utf8.encode(_password.text).length > 72)) {
      error = 'password_length';
    } else if (widget.reset && _password.text != _confirm.text) {
      error = 'password_mismatch';
    }
    if (error != null) { setState(() { _messageKey = error; _success = false; }); return; }
    final originalSession = ref.read(authProvider);
    setState(() { _busy = true; _messageKey = null; _success = false; });
    try {
      final response = await ref.read(apiClientProvider).post(
        ApiConfig.endpoints[widget.reset ? 'resetPassword' : 'forgotPassword']!,
        body: {'email': email, if (widget.reset) ...{'code': _code.text.trim().toUpperCase(), 'newPassword': _password.text}},
      );
      if (!mounted) return;
      setState(() {
        _success = response.confirmsPasswordRecovery(reset: widget.reset);
        _messageKey = _success
            ? (widget.reset ? 'reset_success' : 'forgot_success')
            : 'request_failed';
      });
      if (_success && widget.reset) {
        _password.clear(); _confirm.clear(); _code.clear();
        final currentSession = ref.read(authProvider);
        if (currentSession.token == originalSession.token &&
            currentSession.userId == originalSession.userId) {
          await ref.read(authProvider.notifier).logout();
        }
      }
    } catch (_) {
      if (mounted) setState(() { _messageKey = 'connection_error'; });
    } finally { if (mounted) setState(() { _busy = false; }); }
  }
  void _go(String path) => context.go(authPageLocation(GoRouterState.of(context).uri, path));

  Widget _field(String id, String label, TextEditingController controller, {bool secret = false, TextInputType? keyboard}) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: Semantics(label: id, child: TextField(
        controller: controller, enabled: !_busy, obscureText: secret, keyboardType: keyboard,
        autocorrect: false, enableSuggestions: false,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      )));
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _field('recovery-email', text('email'), _email, keyboard: TextInputType.emailAddress),
    if (widget.reset) ...[
      _field('recovery-code', text('code'), _code),
      _field('recovery-password', text('new_password'), _password, secret: true),
      _field('recovery-confirm', text('confirm_password'), _confirm, secret: true),
    ],
    if (_messageKey != null) Padding(padding: const EdgeInsets.only(bottom: 16), child: Semantics(liveRegion: true, child: Text(text(_messageKey!)))),
    Semantics(label: 'recovery-submit', child: FilledButton(onPressed: _busy ? null : _submit, child: Text(text(_busy ? 'waiting' : widget.reset ? 'reset' : 'email_code')))),
    Semantics(label: 'recovery-reset-link', child: TextButton(onPressed: _busy ? null : () => _go(widget.reset ? '/forgot-password' : '/reset-password'), child: Text(text(widget.reset ? 'new_code' : 'have_code')))),
    if (_success && widget.reset) TextButton(onPressed: () => _go('/login'), child: Text(text('sign_in'))),
  ]);
}
