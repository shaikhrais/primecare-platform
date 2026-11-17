import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' show authProvider;
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

import '../../localization/admin_registered_inventory_text.dart';

const _endpoint = '/v1/governance/screen-health';
const _limit = 25;
const _maxOffset = 100000;

final _inventory = FutureProvider.autoDispose.family<_InventoryPage,
    ({int offset, String search, String role})>((ref, query) async {
  final binding = authProvider.select((auth) =>
      (auth.isAuthenticated, auth.token, auth.userId, auth.tenantId, auth.role));
  final session = ref.watch(binding);
  final client = ref.watch(apiClientProvider);
  var current = true;
  ref.onDispose(() => current = false);
  final token = session.$2;
  if (!session.$1 || token == null || token.isEmpty) {
    return const _InventoryPage(denied: true);
  }
  final uri = Uri(path: _endpoint, queryParameters: {
    'limit': '$_limit',
    'offset': '${query.offset}',
    if (query.search.isNotEmpty) 'search': query.search,
    if (query.role.isNotEmpty) 'role': query.role,
  });
  final reply = await client.getForSession(uri.toString(), token);
  if (!current || ref.read(binding) != session) {
    throw StateError('Inventory session changed');
  }
  if (reply.statusCode == 401 || reply.statusCode == 403) {
    return const _InventoryPage(denied: true);
  }
  final payload = reply.data;
  if (reply.statusCode != 200 || payload is! Map<String, dynamic>) {
    throw const FormatException('Inventory unavailable');
  }
  final source = payload['source'];
  final pagination = payload['pagination'];
  final data = payload['data'];
  if (source is! Map || source['evidenceType'] != 'registered_governance' ||
      source['catalogVersion'] == null || pagination is! Map ||
      pagination['limit'] != _limit || pagination['offset'] != query.offset ||
      pagination['total'] is! int || pagination['hasMore'] is! bool ||
      data is! List) {
    throw const FormatException('Unsupported inventory response');
  }
  final total = pagination['total'] as int;
  final remaining = total > query.offset ? total - query.offset : 0;
  final hasMore = pagination['hasMore'] as bool;
  if (total < 0 || hasMore != (remaining > _limit) ||
      data.length != (remaining < _limit ? remaining : _limit)) {
    throw const FormatException('Invalid inventory pagination');
  }
  final rows = <Map<String, dynamic>>[];
  for (final row in data) {
    if (row is! Map<String, dynamic> || row['screen'] is! String ||
        row['name'] is! String) {
      throw const FormatException('Invalid inventory row');
    }
    rows.add(Map.unmodifiable(row));
  }
  return _InventoryPage(total: total, hasMore: hasMore, rows: rows);
});

class _InventoryPage {
  const _InventoryPage({
    this.denied = false, this.total = 0, this.hasMore = false,
    this.rows = const [],
  });

  final bool denied, hasMore;
  final int total;
  final List<Map<String, dynamic>> rows;
}

/// Read-only catalog for existing mounted native routes. API authorization is
/// independent of route visibility; catalog entries never become links.
class AdminRegisteredInventory extends ConsumerStatefulWidget {
  const AdminRegisteredInventory({
    super.key, required this.title, required this.unavailable,
    this.hint, this.reload,
    this.carousel = false, this.roleFilter = false,
  });

  final String title, unavailable;
  final String? hint, reload;
  final bool carousel, roleFilter;

  @override
  ConsumerState<AdminRegisteredInventory> createState() =>
      _AdminRegisteredInventoryState();
}

class _AdminRegisteredInventoryState
    extends ConsumerState<AdminRegisteredInventory> {
  final _search = TextEditingController();
  final _role = TextEditingController();
  var _query = (offset: 0, search: '', role: '');

  @override
  void dispose() {
    _search.dispose();
    _role.dispose();
    super.dispose();
  }

  void _submit() {
    final search = _search.text.trim(), role = _role.text.trim();
    if (search.length > 200 || role.length > 80 ||
        RegExp(r'[\x00-\x1f]').hasMatch(search + role)) return;
    setState(() => _query = (offset: 0, search: search, role: role));
  }

  void _page(int offset) => setState(() =>
      _query = (offset: offset, search: _query.search, role: _query.role));

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider.select((auth) =>
        (auth.isAuthenticated, auth.token, auth.userId, auth.tenantId, auth.role)),
      (_, _) {
        _search.clear();
        _role.clear();
        setState(() => _query = (offset: 0, search: '', role: ''));
      });
    final language = Localizations.localeOf(context).languageCode;
    String label(String key) => AdminRegisteredInventoryText.resolve(language, key);
    final provider = _inventory(_query);
    final state = ref.watch(provider);
    // Never show a previous AsyncValue while refreshing or changing session.
    final page = !state.isLoading && !state.hasError ? state.asData?.value : null;
    return PrimeScaffold(
      appBar: PrimeAppBar(title: PrimeText(widget.title)),
      body: ListView(
        children: [
          if (page?.denied ?? false)
            _status(label('denied'))
          else ...[
            PrimeTextField(
              controller: _search, maxLength: 200,
              decoration: InputDecoration(hintText: widget.hint ?? label('hint')),
              onSubmitted: (_) => _submit(),
            ),
            if (widget.roleFilter)
              PrimeTextField(
                controller: _role, maxLength: 80,
                decoration: InputDecoration(hintText: label('roleKey')),
                onSubmitted: (_) => _submit(),
              ),
            Wrap(children: [
              PrimeButton(label: label('search'), onPressed: _submit),
              Tooltip(
                message: widget.reload ?? label('reload'),
                child: PrimeButton(
                  label: widget.reload ?? label('reload'), onPressed: () => ref.invalidate(provider),
                ),
              ),
            ]),
            _status(widget.unavailable),
            if (state.isLoading)
              Semantics(liveRegion: true, child: _status(label('loading')))
            else if (state.hasError)
              Semantics(liveRegion: true, child: _status(label('error')))
            else if (page != null) ...[
              if (page.rows.isEmpty)
                _status(label('empty')),
              if (widget.carousel)
                ..._roleGroups(page.rows, label)
              else
                for (final row in page.rows) _InventoryRow(row),
              if (page.rows.isNotEmpty)
                PrimeText(AdminRegisteredInventoryText.resolve(language, 'range', args: {
                  'first': '${_query.offset + 1}',
                  'last': '${_query.offset + page.rows.length}',
                  'total': '${page.total}',
                })),
              Wrap(children: [
                if (_query.offset > 0)
                  PrimeButton(label: label('previous'), onPressed: () => _page(_query.offset - _limit)),
                if (page.hasMore && _query.offset + _limit <= _maxOffset)
                  PrimeButton(label: label('next'), onPressed: () => _page(_query.offset + _limit)),
              ]),
            ],
          ],
        ],
      ),
    );
  }

  Iterable<Widget> _roleGroups(
      List<Map<String, dynamic>> rows, String Function(String) label) sync* {
    final roles = <String, List<Map<String, dynamic>>>{};
    for (final row in rows) {
      final role = _text(row['role']) ?? label('noRole');
      (roles[role] ??= []).add(row);
    }
    for (final entry in roles.entries) {
      yield PrimeText(entry.key);
      yield SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final row in entry.value)
              SizedBox(width: 300, child: _InventoryRow(row)),
          ],
        ),
      );
    }
  }
}

String? _text(Object? value) =>
    value is String && value.trim().isNotEmpty ? value : null;

Widget _status(String value) => PrimeStatusText(value, tone: PrimeStatusTone.muted);

class _InventoryRow extends StatelessWidget {
  const _InventoryRow(this.row);
  final Map<String, dynamic> row;

  @override
  Widget build(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    String label(String key) => AdminRegisteredInventoryText.resolve(language, key);
    final readiness = switch (row['productionReady']) {
      true => label('ready'),
      false => label('notReady'),
      _ => label('unknownReadiness'),
    };
    final blockers = row['blockers'];
    return Semantics(
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeText(_text(row['name']) ?? _text(row['screen']) ?? label('noName')),
          for (final key in ['app', 'role', 'route', 'lifecycle'])
            if (_text(row[key]) case final value?) _status(value),
          _status(readiness),
          if (blockers is List)
            for (final blocker in blockers.whereType<String>()) _status(blocker),
        ],
      ),
    );
  }
}
