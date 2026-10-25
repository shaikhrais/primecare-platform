import 'package:flutter_core/platform/platform_master_repository.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../communications/communication_workspace.dart';
import 'platform_master_controller.dart';
import 'platform_master_catalog.g.dart';

String platformMasterText(BuildContext context, String key) {
  final language = Localizations.localeOf(context).languageCode;
  final labels = platformAdministrationText[language] ?? platformAdministrationText['en']!;
  return liveScreenText(context, 'platform_administration', language, key, labels[key]!);
}

final platformAdministrationAccessProvider = FutureProvider.autoDispose<bool>((ref) async {
  final auth = ref.watch(authProvider);
  if (!auth.isAuthenticated || auth.userId == null || auth.token == null) return false;
  try {
    await PlatformMasterRepository(ref.read(apiClientProvider), actor: auth.userId!, token: auth.token!).index();
    return ref.mounted;
  } catch (_) { return false; }
});

/// Only a successful server capability read reveals the existing navigation.
class PlatformAdministrationLauncher extends ConsumerWidget {
  const PlatformAdministrationLauncher({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(platformAdministrationAccessProvider).asData?.value != true) return const SizedBox.shrink();
    return PrimeButton(label: platformMasterText(context, 'masters'),
      dataCy: 'platform-nav-masters', onPressed: () => context.go('$platformAdministrationRoute?enable-semantics=true'));
  }
}

class _Identity {
  final String user, token;
  final String? tenant, role;
  const _Identity(this.user, this.tenant, this.token, this.role);
  bool matches(AuthState auth) => auth.isAuthenticated && user == auth.userId &&
    tenant == auth.tenantId && token == auth.token && role == auth.role;
  @override
  bool operator ==(Object other) => other is _Identity && user == other.user &&
    tenant == other.tenant && token == other.token && role == other.role;
  @override
  int get hashCode => Object.hash(user, tenant, token, role);
  @override
  String toString() => 'PlatformIdentity(redacted)';
}

class PlatformMasterScreen extends ConsumerWidget {
  const PlatformMasterScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    if (!auth.isAuthenticated || auth.userId == null || auth.userId!.isEmpty ||
        auth.token == null || auth.token!.isEmpty) {
      return const SizedBox.shrink();
    }
    final identity = _Identity(auth.userId!, auth.tenantId, auth.token!, auth.role);
    return _ScopedPlatformMasterScreen(key: ValueKey(identity), identity: identity);
  }
}
class _ScopedPlatformMasterScreen extends ConsumerStatefulWidget {
  final _Identity identity;
  const _ScopedPlatformMasterScreen({super.key, required this.identity});
  @override
  ConsumerState<_ScopedPlatformMasterScreen> createState() => _PlatformMasterScreenState();
}
class _PlatformMasterScreenState extends ConsumerState<_ScopedPlatformMasterScreen> {
  late final PlatformMasterController _controller;
  late final void Function() _removeListener;
  @override
  void initState() {
    super.initState();
    _controller = PlatformMasterController(
      PlatformMasterRepository(ref.read(apiClientProvider), actor: widget.identity.user, token: widget.identity.token),
      isCurrent: () => mounted && widget.identity.matches(ref.read(authProvider)));
    _removeListener = _controller.addListener((_) { if (mounted) setState(() {}); }, fireImmediately: false);
    Future.microtask(_controller.load);
  }
  @override
  void dispose() { _removeListener(); _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final state = _controller.snapshot, theme = context.theme;
    String text(String key) => platformMasterText(context, key);
    final gap = SizedBox(height: theme.spacing.md);
    return Scaffold(appBar: AppBar(title: Text(text('masters'))), body: SafeArea(
      child: SingleChildScrollView(padding: EdgeInsets.all(theme.spacing.lg), child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (state.index != null)
          if (ref.watch(voiceContactControllerProvider) case final VoiceContactController contact) ...[
            VoiceContactVerificationPanel(key: ObjectKey(contact), model: contact,
              language: Localizations.localeOf(context).languageCode), gap,
          ],
        Text(text('master_scope'), style: theme.typography.bodyMedium), gap,
        Text(text('limit'), style: theme.typography.bodyMedium), gap,
        PrimeButton(label: text('account'), dataCy: 'platform-account-link',
          onPressed: () => context.go('/success?enable-semantics=true')), gap,
        PrimeButton(label: text('refresh'), dataCy: 'platform-refresh', isLoading: state.isLoading,
          onPressed: state.isLoading ? null : _controller.load), gap,
        if (state.error != null || state.notice != null || state.isLoading)
          Cy(id: 'platform-status', child: Semantics(liveRegion: true,
            child: Text(text(state.isLoading ? 'working' : state.error ?? state.notice!)))),
        if (state.pending && state.index != null) ...[
          Text(CommunicationWorkspaceCatalog.text(Localizations.localeOf(context).languageCode, 'pending')),
          Text(_controller.pendingFields.values.join(' · ')),
          PrimeButton(label: CommunicationWorkspaceCatalog.text(Localizations.localeOf(context).languageCode, 'retry'),
            dataCy: 'platform-master-create-submit', onPressed: state.isLoading || state.index == null
              ? null : () => _controller.retryPending()),
        ], gap,
        if (state.index != null) ...[
          Cy(id: 'platform-tenant-select', child: DropdownButtonFormField<String>(
            initialValue: state.tenant, isExpanded: true,
            decoration: InputDecoration(labelText: text('select_tenant')),
            hint: Text(text('choose_tenant')),
            items: state.index!.tenants.map((tenant) => DropdownMenuItem(value: tenant.id,
              child: Text(tenant.name, overflow: TextOverflow.ellipsis))).toList(),
            onChanged: state.isLoading || state.pending ? null : (value) {
              if (value != null) _controller.selectTenant(value);
            })), gap,
          if (state.tenant != null && (state.recordsLoaded || state.pending))
            _MasterForm(key: ValueKey((state.tenant, _controller.completedWrites)), controller: _controller), gap,
          Cy(id: 'platform-masters', child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [for (final record in state.records) ...[
              Text(record.label, style: theme.typography.labelBold),
              Text('${record.type} / ${record.code} · ${text(record.status)}', style: theme.typography.bodyMedium), gap,
            ]])),
        ],
      ])),
    ));
  }
}
class _MasterForm extends StatefulWidget {
  final PlatformMasterController controller;
  const _MasterForm({super.key, required this.controller});
  @override
  State<_MasterForm> createState() => _MasterFormState();
}
class _MasterFormState extends State<_MasterForm> {
  final code = TextEditingController(), label = TextEditingController();
  String? type;
  @override
  void dispose() { code.dispose(); label.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final state = widget.controller.snapshot, theme = context.theme;
    String text(String key) => platformMasterText(context, key);
    return Cy(id: 'platform-master-form', child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Cy(id: 'platform-master-create-type', child: DropdownButtonFormField<String>(
        initialValue: type, isExpanded: true, decoration: InputDecoration(labelText: text('type')),
        items: state.index!.types.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: state.isLoading || state.pending ? null : (value) => setState(() => type = value))),
      SizedBox(height: theme.spacing.md),
      PrimeCareTextField(label: text('code'), controller: code, enabled: !state.isLoading && !state.pending, dataCy: 'platform-master-create-code'),
      SizedBox(height: theme.spacing.md),
      PrimeCareTextField(label: text('label'), controller: label, enabled: !state.isLoading && !state.pending, dataCy: 'platform-master-create-label'),
      SizedBox(height: theme.spacing.md),
      if (!state.pending) PrimeButton(label: text('create_master'), dataCy: 'platform-master-create-submit',
        onPressed: !widget.controller.canCreate ? null : () async {
          final result = await widget.controller.create(type ?? '', code.text, label.text);
          if (mounted && result) { code.clear(); label.clear(); }
        }),
    ]));
  }
}
