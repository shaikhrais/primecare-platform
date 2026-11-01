import '../preference_sync/preference_protocol.dart' show PreferenceScope;

const dashboardFamilies = ['project', 'analytics', 'finance', 'crypto'];
const supportingPageKinds = ['invoice', 'pricing', 'authentication', 'coming-soon', 'maintenance', 'error'];
const _fields = {
  'project': ['open', 'review', 'blocked', 'overdue', 'completed'],
  'analytics': ['staff', 'clients', 'visits', 'requests', 'time', 'care', 'plans'],
};

class DashboardPageMetric {
  final String key, sourceField;
  final int? value;
  const DashboardPageMetric(this.key, this.value, this.sourceField);
  Map<String, Object?> toJson() => {'key': key, 'value': value, 'sourceField': sourceField};
}

/// Validates an already authorized response. Hosts retain authorization and session ownership.
class DashboardPageProjection {
  final String family, dataset, status;
  final bool synthetic;
  final List<DashboardPageMetric> metrics;
  DashboardPageProjection._(this.family, this.dataset, this.synthetic, this.status, List<DashboardPageMetric> metrics)
      : metrics = List.unmodifiable(metrics);
  factory DashboardPageProjection.fromResponse(String family, Object? raw, PreferenceScope scope) {
    if (!dashboardFamilies.contains(family)) throw ArgumentError('invalid_family');
    final response = validateDashboardResponseScope(raw, scope);
    DashboardPageProjection result(String status, [List<DashboardPageMetric> metrics = const []]) =>
        DashboardPageProjection._(family, scope.dataset, scope.dataset == 'demo', status, metrics);
    final keys = _fields[family];
    if (keys == null) return result('unavailable');
    final views = response['allowedViews'];
    if (views is! List || !views.contains(family == 'analytics' ? 'operations' : 'tasks')) return result('denied');
    final prefix = family == 'project' ? 'taskStats' : 'stats', values = response[family == 'project' ? 'taskStats' : 'stats'];
    return result('ready', keys.map((key) {
      final value = values is Map ? values[key] : null;
      if (family == 'analytics' && value == null && values is Map && values.containsKey(key)) return DashboardPageMetric(key, null, '$prefix.$key');
      if (value is! num || !value.isFinite || value < 0 || value > 9007199254740991 || value != value.truncateToDouble()) {
        throw ArgumentError('invalid_count');
      }
      return DashboardPageMetric(key, value.toInt(), '$prefix.$key');
    }).toList());
  }
  Map<String, Object?> toJson() => {'family': family, 'dataset': dataset, 'synthetic': synthetic,
    'sourceApiId': 16578, 'status': status, 'metrics': metrics.map((m) => m.toJson()).toList()};
}

String supportingPageStatus(String kind) {
  if (!supportingPageKinds.contains(kind)) throw ArgumentError('invalid_page');
  return ['coming-soon', 'maintenance', 'error'].contains(kind) ? 'static-$kind' : 'unavailable';
}

Map<String, dynamic> validateDashboardResponseScope(Object? raw, PreferenceScope scope) {
    if (raw is! Map || raw['identity'] is! Map || raw['organization'] is! Map) throw ArgumentError('scope_changed');
    final identity = raw['identity'] as Map, organization = raw['organization'] as Map;
    if (raw['dataset'] != scope.dataset || raw['synthetic'] != (scope.dataset == 'demo') ||
        identity['userId'] != scope.userId || identity['role'] != scope.role || organization['id'] != scope.tenantId) {
      throw ArgumentError('scope_changed');
    }
  return Map<String, dynamic>.from(raw);
}
