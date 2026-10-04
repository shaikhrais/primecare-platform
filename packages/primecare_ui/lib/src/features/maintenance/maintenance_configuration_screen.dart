import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

/// Shared organization maintenance workspace. Server authorization is authoritative.
class MaintenanceConfigurationScreen extends ConsumerStatefulWidget {
  const MaintenanceConfigurationScreen({super.key});
  @override
  ConsumerState<MaintenanceConfigurationScreen> createState() => _MaintenanceConfigurationState();
}
class _MaintenanceConfigurationState extends ConsumerState<MaintenanceConfigurationScreen> {
  static const endpoint = '/v1/auth/maintenance/configuration';
  final _sender = TextEditingController();
  final _accountEmail = TextEditingController();
  final _accountPassword = TextEditingController();
  final Map<String, Map<String, TextEditingController>> _templates = {};
  Map<String, dynamic>? _data;
  bool _busy = false;
  String? _message;
  @override
  void initState() { super.initState(); Future.microtask(_load); }
  @override
  void dispose() {
    for (final c in [_sender, _accountEmail, _accountPassword, ..._templates.values.expand((v) => v.values)]) { c.dispose(); }
    super.dispose();
  }
  bool get _allowed {
    final session = ref.read(authProvider);
    return session.isAuthenticated && ['ceo', 'maintenance'].contains(session.role);
  }
  Future<void> _load() async {
    if (!_allowed || _busy) return;
    setState(() { _busy = true; });
    try {
      final r = await ref.read(apiClientProvider).get(endpoint);
      if (!mounted) return;
      if (r.statusCode != 200 || r.data is! Map) { setState(() { _data = null; _message = _error(r.data); }); return; }
      final data = Map<String, dynamic>.from(r.data as Map);
      for (final c in _templates.values.expand((v) => v.values)) { c.dispose(); }
      _templates.clear();
      for (final entry in (data['templates'] as Map).entries) {
        final t = entry.value as Map;
        _templates[entry.key.toString()] = {for (final field in ['subject', 'title', 'body']) field: TextEditingController(text: t[field] as String)};
      }
      setState(() { _data = data; _sender.text = data['sender'] as String; });
    } catch (_) { if (mounted) setState(() { _message = 'Unable to load configuration. Check your connection and sign-in.'; }); }
    finally { if (mounted) setState(() { _busy = false; }); }
  }
  String _error(dynamic data) => data is Map && data['error'] is String ? data['error'] as String : 'Request failed. Check your connection and sign-in.';
  Future<void> _post(String path, Map<String, dynamic> body) async {
    if (_busy || !_allowed) return;
    setState(() { _busy = true; _message = null; });
    bool reload = false;
    try {
      final r = await ref.read(apiClientProvider).post(path, body: body);
      if (!mounted) return;
      setState(() { _message = r.statusCode == 200 || r.statusCode == 201 ? (r.data is Map && r.data['message'] is String ? r.data['message'] as String : 'Maintenance account created. Share access through your approved IT process.') : _error(r.data); });
      if (r.statusCode == 200 || r.statusCode == 201) {
        _accountPassword.clear(); reload = path == endpoint || path.endsWith('/test-email');
      }
    } catch (_) { if (mounted) setState(() { _message = 'Unable to save. Check your connection and try again.'; }); }
    finally { if (mounted) setState(() { _busy = false; }); }
    if (reload && mounted) await _load();
  }
  Widget _field(String label, TextEditingController controller, {bool secret = false, int lines = 1}) => Padding(
    padding: const EdgeInsets.only(bottom: 16), child: TextField(controller: controller, enabled: !_busy,
      obscureText: secret, autocorrect: !secret, enableSuggestions: !secret, maxLines: lines,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder())));
  Widget _section(String title, List<Widget> children) => Card(child: Padding(padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 16), ...children])));
  @override
  Widget build(BuildContext context) {
    final session = ref.watch(authProvider);
    if (!session.isAuthenticated || !['ceo', 'maintenance'].contains(session.role)) {
      return Scaffold(appBar: AppBar(title: const Text('IT maintenance')), body: const Center(child: Text('CEO or maintenance access required.')));
    }
    final data = _data;
    return Scaffold(
      appBar: AppBar(title: const Text('IT maintenance'), actions: [IconButton(tooltip: 'Reload configuration', onPressed: _busy ? null : _load, icon: const Icon(Icons.refresh)), IconButton(tooltip: 'Sign out', onPressed: () async { await ref.read(authProvider.notifier).logout(); if (context.mounted) context.go('/login'); }, icon: const Icon(Icons.logout))]),
      body: Align(alignment: Alignment.topCenter, child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 960),
        child: ListView(padding: const EdgeInsets.all(16), children: [
          const Text('Manage email delivery and templates for your organization. Changes take effect on the server without rebuilding the app. This role does not grant access to patient records or other organizations.'),
          if (_busy) const LinearProgressIndicator(),
          if (_message != null) Padding(padding: const EdgeInsets.all(16), child: Semantics(liveRegion: true, child: Text(_message!))),
          if (data != null) ...[
            _section('Status and pending work', [
              Text(data['emailReady'] == true ? 'Email configuration is present. Inbox delivery still needs verification.' : 'Email setup is incomplete. Password recovery cannot send email yet.'),
              const SizedBox(height: 12),
              for (final task in data['pending'] as List) Padding(padding: const EdgeInsets.only(bottom: 10), child: Text('• $task')),
            ]),
            _section('Email delivery', [
              const Text('Provider: Cloudflare Email Service. No provider API key is required.'),
              const SizedBox(height: 12),
              _field('Verified sender email', _sender),
              const SizedBox(height: 16),
              FilledButton(onPressed: _busy || data['settingsReady'] != true ? null : () => _post(endpoint, {
                'sender': _sender.text.trim(), 'revision': data['revision'],
                'templates': {for (final entry in _templates.entries) entry.key: {for (final field in entry.value.entries) field.key: field.value.text}},
              }), child: const Text('Save email settings and templates')),
              TextButton(onPressed: _busy ? null : () => _post('$endpoint/test-email', {}), child: const Text('Send test email to my signed-in account')),
            ]),
            _section('Shared email template library', [
              const Text('Edit plain text. Keep every required {{placeholder}}. Password reset is connected; the other event integrations are pending.'),
              for (final entry in _templates.entries) ExpansionTile(title: Text(entry.key.replaceAll('_', ' ')),
                subtitle: Text('Required: ${((data['templates'] as Map)[entry.key]['required'] as List).join(', ')}'),
                children: [for (final field in entry.value.entries) _field(field.key, field.value, lines: field.key == 'body' ? 5 : 1)]),
            ]),
            _section('Deployment configuration', [for (final item in data['externalConfiguration'] as List) ListTile(title: Text(item['name'] as String), subtitle: Text('${item['value']}\n${item['instructions']}'))]),
            if (session.role == 'ceo') _section('Create an IT maintenance account', [
              const Text('Creates a named maintenance user in your organization. Use a unique account for each IT team member. A strong initial password must be shared through your approved process.'),
              const SizedBox(height: 16), _field('IT team member email', _accountEmail), _field('Initial password (12+ characters)', _accountPassword, secret: true),
              FilledButton(onPressed: _busy ? null : () => _post('/v1/auth/register', {'email': _accountEmail.text.trim(), 'password': _accountPassword.text, 'role': 'maintenance'}), child: const Text('Create maintenance account')),
            ]),
            _section('Recent maintenance activity', [if ((data['audit'] as List).isEmpty) const Text('No maintenance changes recorded.'), for (final item in data['audit'] as List) ListTile(title: Text(item['action'].toString().replaceAll('_', ' ')), subtitle: Text(item['created_at'].toString()))]),
          ],
        ]))),
    );
  }
}
