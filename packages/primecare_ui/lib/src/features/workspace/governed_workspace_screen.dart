import '../training/admin_training_launcher.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../reports/admin_reports_panel.dart';

/// Shared presentation of server-authorized governance pages and live telemetry.
/// The server supplies navigation, labels, grants and organization scope.
abstract class GovernedWorkspaceEntry extends StatelessWidget {
  final String route;
  const GovernedWorkspaceEntry({super.key, required this.route});
  @override
  Widget build(BuildContext context) => GovernedWorkspaceScreen(route: route);
}

// Equality preserves the exact session boundary without exposing a bearer token
// through Flutter's diagnostic key strings.
class _WorkspaceIdentity {
  final String user, tenant, token;
  final String? role;
  const _WorkspaceIdentity(this.user, this.tenant, this.token, this.role);
  @override
  bool operator ==(Object other) => other is _WorkspaceIdentity &&
      user == other.user && tenant == other.tenant && token == other.token && role == other.role;
  @override
  int get hashCode => Object.hash(user, tenant, token, role);
  @override
  String toString() => 'WorkspaceIdentity(redacted)';
}

class GovernedWorkspaceScreen extends ConsumerWidget {
  final String route;
  const GovernedWorkspaceScreen({super.key, required this.route});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scope = ref.watch(authProvider.select((s) =>
      (s.isAuthenticated, s.userId, s.tenantId, s.token, s.role)));
    if (!scope.$1 || scope.$2 == null || scope.$2!.isEmpty ||
        scope.$3 == null || scope.$3!.isEmpty || scope.$4 == null || scope.$4!.isEmpty) {
      return const SizedBox.shrink();
    }
    return _ScopedWorkspaceScreen(
      key: ValueKey(_WorkspaceIdentity(scope.$2!, scope.$3!, scope.$4!, scope.$5)), route: route);
  }
}

class _ScopedWorkspaceScreen extends ConsumerStatefulWidget {
  final String route;
  const _ScopedWorkspaceScreen({super.key, required this.route});
  @override
  ConsumerState<_ScopedWorkspaceScreen> createState() => _WorkspaceState();
}

class _WorkspaceState extends ConsumerState<_ScopedWorkspaceScreen> {
  Map<String, dynamic>? _workspace;
  String? _error;
  bool _loading = false;
  String _search = '';
  final _searchController = TextEditingController();

  String label(String key) => liveScreenText(context,'workspace',Localizations.localeOf(context).languageCode,key,Localizations.localeOf(context).languageCode=='en' ? ((_workspace?['resources'] as Map?)?['workspace.$key']?.toString() ?? 'workspace.$key'.tr()) : 'workspace.$key'.tr());
  List<Map<String, dynamic>> list(dynamic value) => value is List
      ? value.whereType<Map<dynamic, dynamic>>().map((v) => Map<String, dynamic>.from(v)).toList() : [];
  List<Map<String, dynamic>> get _pages => list(_workspace?['screens']);
  @override
  void initState() { super.initState(); Future.microtask(_load); }
  @override
  void dispose() { _searchController.dispose(); super.dispose(); }
  @override
  void didUpdateWidget(_ScopedWorkspaceScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.route != widget.route) { _workspace = null; Future.microtask(_load); }
  }
  Future<void> _load() async {
    if (_loading) return;
    setState(() { _loading = true; _error = null; });
    try {
      final response = await ref.read(apiClientProvider).get('/v1/governance/workspace');
      if (!mounted) return;
      if (response.statusCode != 200 || response.data is! Map) {
        setState(() { _workspace = null; _error = label('unavailable'); });
      } else {
        setState(() { _workspace = Map<String, dynamic>.from(response.data as Map); });
      }
    } catch (_) { if (mounted) setState(() { _workspace = null; _error = label('unavailable'); }); }
    finally { if (mounted) setState(() { _loading = false; }); }
  }
  Widget _card(String title, Widget child, String semantics) => Semantics(
    label: semantics, container: true,
    child: Card(child: Padding(padding: EdgeInsets.all(context.theme.spacing.lg),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(title, style: context.theme.typography.h3),
        SizedBox(height: context.theme.spacing.md), child,
      ]))),
  );
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final pages = _pages;
    final matching = pages.where((p) => p['route'] == widget.route).toList();
    final page = matching.isEmpty ? null : matching.first;
    final overview = Map<String, dynamic>.from((_workspace?['overview'] as Map?) ?? {});
    final inventory = list(_workspace?['inventory']);
    final filtered = inventory.where((p) => '${p['name']} ${p['role']} ${p['appCode']} ${p['route']}'
      .toLowerCase().contains(_search.toLowerCase())).toList();
    final allowed = pages.map((p) => p['code']).toSet();
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(title: Text(page?['name']?.toString() ?? label('title')), actions: [
        if(_workspace!=null && page!=null)const AdminTrainingLauncher(compact:true),
        IconButton(tooltip: label('refresh'), onPressed: _loading ? null : _load, icon: const Icon(Icons.refresh)),
        IconButton(tooltip: label('account'), onPressed: () => context.go('/success'), icon: const Icon(Icons.account_circle_outlined)),
        IconButton(tooltip: label('sign_out'), onPressed: () async {
          await ref.read(authProvider.notifier).logout(); if (context.mounted) context.go('/login');
        }, icon: const Icon(Icons.logout)),
      ]),
      body: _loading ? const Center(child: CircularProgressIndicator())
      : _error != null ? Center(child: Semantics(liveRegion: true, child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(_error!), PrimeButton(label: label('refresh'), onPressed: _load),
      ])))
      : _workspace == null ? const SizedBox.shrink()
      : page == null ? Center(child: Text(label('forbidden')))
      : ListView(padding: EdgeInsets.all(theme.spacing.lg), children: [
        Semantics(header: true, label: 'screen-${page['code']}', child: Text(page['name'].toString(), style: theme.typography.h1)),
        SizedBox(height: theme.spacing.md),
        _card(label('title'), Wrap(spacing: theme.spacing.lg, runSpacing: theme.spacing.md, children: [
          _metric(label('users'), overview['activeAccounts']),
          _metric(label('sessions'), overview['activeSessions']),
          _metric(label('pages'), pages.length),
          _metric(label('pending'), inventory.where((p) => (p['blockers'] as List).isNotEmpty).length),
        ]), 'workspace-metrics'),
        _card(label('pages'), Wrap(spacing: theme.spacing.sm, runSpacing: theme.spacing.sm, children: [
          for (final item in list(_workspace?['actions'])) TextButton(onPressed: () => context.go(item['route'].toString()), child: Text(item['name'].toString())),
          for (final item in pages) Semantics(label: 'sidebar-item-${item['code']}',
            child: TextButton(onPressed: () => context.go(item['route'].toString()), child: Text(item['name'].toString()))),
        ]), 'workspace-navigation'),
        _card(label('roles'), Column(children: [
          for (final item in list(overview['accountRoles'])) ListTile(title: Text(item['role'].toString()), trailing: Text(item['count'].toString())),
          for (final item in list(overview['metrics'])) ListTile(title: Text(label(item['code'].toString())),
            subtitle: item['available'] == true ? null : Text(label('no_data')),
            trailing: item['available'] == true ? Text(item['count'].toString()) : null),
        ]), 'workspace-account-roles'),
        _card(label('activity'), list(overview['activity']).isEmpty ? Text(label('empty')) : Column(children: [
          for (final item in list(overview['activity'])) ListTile(title: Text(item['action'].toString()), subtitle: Text(item['created_at'].toString())),
        ]), 'workspace-recent-activity'),
        if ((_workspace?['reporting'] as Map?)?['screens'] is List &&
            ((_workspace!['reporting'] as Map)['screens'] as List).contains(page['code']))
          AdminReportsPanel(key: ValueKey('reports-${page['code']}'), endpoint: (_workspace!['reporting'] as Map)['endpoint'] as String),
        for (final section in list(page['sections'])) _section(page, section, overview, pages),
        _card(label('inventory'), Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Semantics(label: 'workspace-search', child: TextField(controller: _searchController,
            decoration: InputDecoration(labelText: label('search'), prefixIcon: const Icon(Icons.search)),
            onChanged: (value) => setState(() { _search = value; }))),
          SizedBox(height: theme.spacing.md),
          for (final item in filtered.take(100)) ListTile(
            title: Text(item['name'].toString()), subtitle: Text('${item['appCode']} · ${item['role']}\n${(item['blockers'] as List).join('\n')}'),
            trailing: allowed.contains(item['code']) ? IconButton(tooltip: label('open'), icon: const Icon(Icons.arrow_forward),
              onPressed: () => context.go(item['route'].toString())) : null),
        ]), 'workspace-inventory'),
      ]),
    );
  }
  Widget _metric(String title, dynamic value) => Semantics(label: title, child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [Text('$value', style: context.theme.typography.h1), Text(title)]));
  Widget _section(Map<String,dynamic> page, Map<String,dynamic> section,
      Map<String,dynamic> overview, List<Map<String,dynamic>> pages) {
    final dashboard = page['renderer'] == 'dashboard';
    final children = <Widget>[if (section['purpose'] != null) Text(section['purpose'].toString())];
    if (section['type'] == 'header') {
      children.add(Text((_workspace?['identity'] as Map?)?['role']?.toString() ?? ''));
    } else if (section['type'] == 'action_bar') {
      children.add(Wrap(children: [for (final item in pages) TextButton(
        onPressed: () => context.go(item['route'].toString()), child: Text(item['name'].toString()))]));
    } else if (dashboard && section['type'] == 'metrics') {
      children.add(Wrap(spacing: context.theme.spacing.lg, children: [
        _metric(label('users'), overview['activeAccounts']), _metric(label('sessions'), overview['activeSessions'])]));
    } else if (dashboard && section['type'] == 'chart') {
      final total = (overview['activeAccounts'] as num?)?.toDouble() ?? 0;
      for (final role in list(overview['accountRoles'])) {
        children.add(Semantics(label: '${role['role']}: ${role['count']}', child: ListTile(
          title: Text('${role['role']} · ${role['count']}'), subtitle: LinearProgressIndicator(
            value: total == 0 ? 0 : ((role['count'] as num).toDouble()/total).clamp(0.0,1.0).toDouble()))));
      }
    } else if (dashboard && section['type'] == 'list') {
      final activity = list(overview['activity']);
      if (activity.isEmpty) children.add(Text(label('empty')));
      for (final item in activity) children.add(ListTile(title: Text(item['action'].toString()), subtitle: Text(item['created_at'].toString())));
    } else {
      children.add(Text(label('no_data')));
    }
    for (final element in list(section['elements'])) {
      children.add(Semantics(label: element['testId']?.toString(), child: ListTile(
        title: Text(element['label']?.toString() ?? element['key'].toString()),
        subtitle: element['actionRequired'] == 1 ? Text(label('no_action')) : null)));
    }
    return _card(section['name'].toString(), Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      section['testId']?.toString() ?? section['code'].toString());
  }
}
