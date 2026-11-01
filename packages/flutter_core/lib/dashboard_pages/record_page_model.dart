import '../preference_sync/preference_protocol.dart' show PreferenceScope;
import 'dashboard_page_model.dart' show validateDashboardResponseScope;
String _text(Object? raw, [int max = 500]) {
  if (raw is! String || raw.trim().isEmpty || raw.length > max) throw ArgumentError('invalid_record');
  return raw;
}
List<Object?> _rows(Object? raw) {
  if (raw is! List || raw.length > 100) throw ArgumentError('invalid_records');
  return List<Object?>.from(raw);
}
class RecordPageRow {
  final String type, title, detail;
  const RecordPageRow(this.type, this.title, this.detail);
  Map<String, Object?> toJson() => {'type': type, 'title': title, 'detail': detail};
}
class RecordPageProjection {
  final String kind, dataset, status;
  final bool synthetic;
  final List<RecordPageRow> rows;
  RecordPageProjection._(this.kind, this.dataset, this.synthetic, this.status, List<RecordPageRow> rows) : rows = List.unmodifiable(rows);
  factory RecordPageProjection.fromResponse(String kind, Object? raw, PreferenceScope scope, {String query = ''}) {
    if (!['activity', 'search'].contains(kind)) throw ArgumentError('invalid_page');
    if (query.length > 100) throw ArgumentError('invalid_query');
    final response = validateDashboardResponseScope(raw, scope), views = response['allowedViews'];
    bool allowed(String view) => views is List && views.contains(view);
    RecordPageProjection result(String status, [List<RecordPageRow> rows = const []]) => RecordPageProjection._(kind, scope.dataset, scope.dataset == 'demo', status, rows);
    final rows = <RecordPageRow>[];
    if (kind == 'activity') {
      if (!allowed('audit')) return result('denied');
      for (final event in _rows(response['events'])) {
        if (event is! Map) throw ArgumentError('invalid_record');
        final title = _text(event['action'], 200), detail = _text(event['created_at'], 100);
        if (DateTime.tryParse(detail) == null) throw ArgumentError('invalid_record');
        rows.add(RecordPageRow('activity', title, detail));
      }
    } else {
      if (!allowed('tasks') && !allowed('workflows')) return result('denied');
      for (final source in ['tasks', 'workflows']) {
        if (!allowed(source)) continue;
        for (final item in _rows(response[source])) {
          if (item is! Map) throw ArgumentError('invalid_record');
          rows.add(RecordPageRow(source == 'tasks' ? 'task' : 'workflow', _text(item['title']), _text(item[source == 'tasks' ? 'id' : 'flow_id'], 200)));
        }
      }
      final search = query.toLowerCase();
      rows.removeWhere((row) => !('${row.title} ${row.detail}').toLowerCase().contains(search));
    }
    return result(rows.isEmpty ? 'empty' : 'ready', rows);
  }
  Map<String, Object?> toJson() => {'kind': kind, 'dataset': dataset, 'synthetic': synthetic,
    'sourceApiId': 16578, 'bounded': true, 'status': status, 'rows': rows.map((row) => row.toJson()).toList()};
}
